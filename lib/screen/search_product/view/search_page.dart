import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:furniture_app/data/models/product.dart';
import 'package:furniture_app/data/values/fonts.dart';
import 'package:furniture_app/data/values/strings.dart';
import 'package:furniture_app/screen/search_product/controller/search_controller.dart';
import 'package:get/get.dart';

import '../../../data/paths/icon_path.dart';
import '../../../data/values/colors.dart';
import '../../product_detail/view/product_detail_page.dart';

class SearchPage extends GetView<SearchPageController> {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchPageController>(
        builder: (value) => Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: backgroundColor,
              appBar: _appBar(),
              body: _bodyContent(),
            ));
  }

  AppBar _appBar() {
    return AppBar(
      leading: const BackButton(color: Colors.black),
      elevation: 0,
      backgroundColor: backgroundColor,
      title: TextField(
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 2.0),
          prefixIcon: Icon(
            Icons.search,
          ),
          hintText: 'Search',
          hintStyle: TextStyle(color: Color.fromRGBO(158, 158, 158, 1)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
          ),
        ),
        onSubmitted: (value) {
          controller.loadSearch(value);
        },
      ),
    );
  }

  Widget _bodyContent() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            if (controller.searchtext.length > 0)
              Row(
                children: [
                  _textTitle('Last Search'),
                  const Spacer(),
                  // _textTitle(
                  //   'View All',
                  // ),
                ],
              ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                  controller.searchtext.length,
                  (index) => _recentSearch(
                      controller.searchtext[index], controller, index)),
            ),
            _textTitle('Related Products'),
            Container(
              height: Get.height - 400,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: MasonryGridView.count(
                itemCount: controller.products.length,
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                itemBuilder: (context, index) {
                  return productItem(controller.products[index]!);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget productItem(Product product) {
    double height = (Get.width - 60) / 2 * 0.7;
    if (height > 200) height = 200;

    // Provide a fallback image if the imagePath list is empty or null
    final imageUrl =
        (product.imagePath != null && product.imagePath!.isNotEmpty)
            ? product.imagePath![0]
            : 'https://via.placeholder.com/150'; // Fallback image URL

    return InkWell(
      onTap: () {
        controller.clickProduct(product);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            product.name.toString(),
            style: TextStyle(fontFamily: jose_fin_sans, color: textGrey2Color),
          ),
          const SizedBox(height: 10),
          Text(
            "\$ ${product.price}",
            style: TextStyle(fontFamily: jose_fin_sans, color: textBlackColor),
          )
        ],
      ),
    );
  }
}

// Widget to List.View Recent Product
Widget _recentSearch(
    String nameProduct, SearchPageController controller, int index) {
  return InkWell(
    onTap: () {
      controller.loadSearch(nameProduct);
    },
    child: Container(
      margin: const EdgeInsets.all(13),
      child: Row(
        children: [
          Row(
            children: [
              Container(
                height: 18.0,
                width: 18.0,
                child: const IconButton(
                  padding: EdgeInsets.all(0.0),
                  color: Colors.red,
                  icon: Icon(Icons.schedule, size: 18.0),
                  onPressed: null,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(nameProduct),
            ],
          ),
          const Spacer(),
          // Container(
          //   height: 18.0,
          //   width: 18.0,
          //   child: const IconButton(
          //     padding: EdgeInsets.all(0.0),
          //     color: Colors.red,
          //     icon: Icon(Icons.clear, size: 18.0),
          //     onPressed:
          //   ),
          // ),
          InkWell(
            onTap: () {
              controller.onRemove(index);
            },
            child: Icon(
              Icons.clear,
              size: 18.0,
              color: Colors.red,
            ),
          )
        ],
      ),
    ),
  );
}

//Widget Related Product Customize
Widget _relatedProduct(dynamic product, int index) {
  return InkWell(
    onTap: () {
      Get.to(ProductDetailPage(), arguments: product);
    },
    child: Container(
      margin: const EdgeInsets.all(13),
      height: 170,
      width: 160,
      child: Stack(children: <Widget>[
        Container(
          height: 200,
          width: 150,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(image_demo_prodcut), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(10)),
        ),
        Positioned(
          right: 15,
          top: 10,
          child: Container(
              height: 20.0,
              width: 20.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.9),
                //border: Border.all(width: 2),
              ),
              child: const IconButton(
                padding: EdgeInsets.all(0.0),
                color: Colors.red,
                icon: Icon(Icons.favorite, size: 12.0),
                onPressed: null,
              )),
        ),
        const Positioned(
          bottom: 20,
          left: 10,
          child: Center(
            child: Text(
              'Modern Sofa',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          left: 10,
          child: Center(
            child: Text(
              index.toString(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ]),
    ),
  );
}

Widget _textTitle(String _title) {
  return Container(
    margin: const EdgeInsets.all(10),
    child: Text(
      _title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    ),
  );
}
