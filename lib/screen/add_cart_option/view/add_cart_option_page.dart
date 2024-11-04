import 'package:flutter/material.dart';
import 'package:furniture_app/data/values/colors.dart';

import '../controller/add_cart_option_controller.dart';

class AddCartOptionState extends State<AddCartOption> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 2 / 3,
      margin: EdgeInsets.only(left: 20, right: 20),
      child: SingleChildScrollView(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 40),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      width: 150,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(widget.imagePath),
                              fit: BoxFit.cover)),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Price:${widget.price}",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: buttonColor,
              ),
              Text(
                "Color",
                style: TextStyle(fontSize: 20),
              ),
              colorCustom(),
              Text(
                "Size",
                style: TextStyle(fontSize: 20),
              ),
              sizeCustom(),
              amountCustom(),
              buttonCustom(),
              SizedBox(
                height: 10,
              )
            ]),
      ),
    );
  }

  Widget colorCustom() {
    List<Widget> items = [];
    for (int i = 0; i < widget.colors.length; i++) {
      items.add(colorWidget(i, i == widget.chooseColor, widget.colors[i]));
      items.add(SizedBox(
        width: 10,
      ));
    }
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: items,
        ),
      ),
    );
  }

  Widget colorWidget(int index, bool onSelectedColor, Color title) {
    return InkWell(
      onTap: () {
        setState(() {
          if (onSelectedColor == false) widget.chooseColor = index;
        });
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: title.withAlpha(150),
            child: onSelectedColor
                ? CircleAvatar(
                    radius: 15,
                    backgroundColor: title,
                    child: Icon(
                      Icons.check,
                    ),
                  )
                : CircleAvatar(radius: 15, backgroundColor: title),
          ),
        ],
      ),
    );
  }

  Widget sizeCustom() {
    List<Widget> items = [];
    if (widget.sizes.isNotEmpty) {
      items.add(sizeWidget(widget.sizes[0]));
    } else {
      // Handle empty sizes list
      items.add(Text("No sizes available"));
    }
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: items,
        ),
      ),
    );
  }

  Widget sizeWidget(String title) {
    return InkWell(
      onTap: () {
        // setState(() {
        //   if (onSelectedSize == true) onSelectedSize = !onSelectedSize;
        // });
      },
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                //border: Border.all(color: Colors.grey),
                color: true ? buttonColor : Color.fromARGB(255, 207, 207, 207),
                borderRadius: BorderRadius.circular(8)),
            child: Text(
              title.toString(),
              style: TextStyle(color: true ? Colors.black : Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget amountCustom() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Amount",
          style: TextStyle(fontSize: 20),
        ),
        Container(
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: buttonColor,
          ),
          child: Row(
            children: [
              Container(
                width: 35,
                height: 30,
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(5)),
                child: IconButton(
                  onPressed: () {
                    decrement();
                  },
                  icon: Icon(
                    Icons.remove,
                    size: 16,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 3),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white),
                child: Text(
                  widget.amount.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
              Container(
                width: 35,
                height: 30,
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(5)),
                child: IconButton(
                  onPressed: () {
                    increment();
                  },
                  icon: Icon(
                    Icons.add,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buttonCustom() {
    return InkWell(
      onTap: () {
        print("This is add cart");
        widget.addCart();
        Navigator.pop(context);
      },
      child: Container(
        margin: EdgeInsets.only(left: 110, right: 110, top: 30),
        alignment: Alignment.center,
        height: 50,
        width: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: buttonColor,
        ),
        child: Text(
          "Add to cart",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
        ),
      ),
    );
  }

  void increment() {
    setState(() {
      if (widget.amount >= 0 && widget.amount < 10) {
        widget.amount++;
      }
    });
  }

  void decrement() {
    setState(() {
      if (widget.amount > 1) {
        widget.amount--;
      }
    });
  }
}
