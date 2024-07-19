import 'package:get/get.dart';
import '../../../../data/repository/categories/category_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/category/categories_model_tabs.dart';
import 'home_service_controller.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final isIconLoading = false.obs;

  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModelTabs> allCategories = <CategoryModelTabs>[].obs;
  RxList<CategoryModelTabs> featuredCategories = <CategoryModelTabs>[].obs;

  var selectedIndex = 0.obs;
  final RxString selectedCategory = RxString('All');


  void updateIndex(int index) {
    selectedIndex.value = index;
    selectedCategory.value = featuredCategories[index].category;
    print('Selected Category: ${selectedCategory.value}');

  }

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  /// -- Load Category Data
  Future<void> fetchCategories() async {
    try {
      // Show Loader
      isLoading.value = true;
      isIconLoading.value = true;

      // Fetch categories from data source
      final categories = await _categoryRepository.getAllCategories();

      //update the category list
      allCategories.assignAll(categories);

      //add all category
      allCategories.add(CategoryModelTabs(isFeatured: true, id: '0', category: 'All', icon: YHMImages.allSvg));

      allCategories.sort((a, b) => a.id.compareTo(b.id));

      //filter featured categories
      featuredCategories.assignAll(allCategories.where((category) => category.isFeatured).toList());
    } catch (e) {
      print(e.toString());
      YHMLoaders.errorSnackBar(title: 'Something went wrong', message: e.toString());
    } finally {
      // Remove Loader
      isLoading.value = false;
    }
  }
}
