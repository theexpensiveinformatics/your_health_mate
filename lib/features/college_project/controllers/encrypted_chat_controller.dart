import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pointycastle/export.dart' as crypto;
import 'dart:convert'; // for base64 encoding/decoding
import 'dart:typed_data';
import 'dart:math';

import 'package:your_health_mate/features/personalization/controller/user_controller.dart';

class EncryptedChatController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final userName = UserController.instance.user.value.fullName;


  late crypto.AsymmetricKeyPair<crypto.RSAPublicKey, crypto.RSAPrivateKey> keyPair;

  @override
  void onInit() {
    super.onInit();
    keyPair = generateRSAKeyPair(); // Generate RSA key pair when the controller is initialized
  }

  // Generate RSA Key Pair
  // Generate RSA Key Pair
  crypto.AsymmetricKeyPair<crypto.RSAPublicKey, crypto.RSAPrivateKey> generateRSAKeyPair() {
    final keyGen = crypto.RSAKeyGenerator(); // Initialize RSA Key Generator
    final secureRandom = _getSecureRandom(); // Secure Random Generator

    keyGen.init(crypto.ParametersWithRandom(
      crypto.RSAKeyGeneratorParameters(
        BigInt.from(65537), // Public exponent
        2048,               // Key size (2048-bit RSA key)
        64,                 // Certainty factor
      ),
      secureRandom,   // SecureRandom for randomness
    ));

    // Cast the generated key pair to RSA key types
    final pair = keyGen.generateKeyPair();
    final publicKey = pair.publicKey as crypto.RSAPublicKey;   // Cast public key
    final privateKey = pair.privateKey as crypto.RSAPrivateKey; // Cast private key

    return crypto.AsymmetricKeyPair(publicKey, privateKey); // Return the typed key pair
  }


  // Helper to generate a SecureRandom
  crypto.SecureRandom _getSecureRandom() {
    final secureRandom = crypto.SecureRandom('Fortuna')
      ..seed(crypto.KeyParameter(_randomBytes(32))); // 32 bytes seed
    return secureRandom;
  }

  // Generate random bytes for the seed
  Uint8List _randomBytes(int length) {
    final random = Random.secure();
    final bytes = Uint8List(length);
    for (int i = 0; i < length; i++) {
      bytes[i] = random.nextInt(256);
    }
    return bytes;
  }

  // Encrypt message using RSA Public Key
  String encryptMessage(String message, crypto.RSAPublicKey publicKey) {
    final cipher = crypto.RSAEngine()
      ..init(true, crypto.PublicKeyParameter<crypto.RSAPublicKey>(publicKey)); // true=encrypt
    final encrypted = cipher.process(Uint8List.fromList(utf8.encode(message))); // utf8 encoding
    return base64Encode(encrypted); // Use base64 instead of hex for simplicity
  }

  // Decrypt message using RSA Private Key
  String decryptMessage(String encryptedMessage) {
    final cipher = crypto.RSAEngine()
      ..init(false, crypto.PrivateKeyParameter<crypto.RSAPrivateKey>(keyPair.privateKey)); // false=decrypt
    final decrypted = cipher.process(base64Decode(encryptedMessage)); // base64 decoding
    return utf8.decode(decrypted); // utf8 decoding
  }

  // Send encrypted message to Firebase
  Future<void> sendMessage(String message, String chatId, crypto.RSAPublicKey recipientPublicKey) async {
    String encryptedMessage = encryptMessage(message, recipientPublicKey);
    await _firestore.collection('chats/$chatId/messages').add({

      'sender': UserController.instance.user.value.fullName, // Replace with actual sender ID
      'message': encryptedMessage,
      'sender_id':UserController.instance.user.value.id,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // Retrieve and decrypt messages from Firebase
  Stream<List<String>> getMessages(String chatId) {
    return _firestore.collection('chats/$chatId/messages')
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return decryptMessage(doc['message']); // Decrypt the message
      }).toList();
    });
  }
}
