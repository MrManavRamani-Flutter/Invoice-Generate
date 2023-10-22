// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:invoice_generator/utils/util.dart';

class CartPage extends StatefulWidget {
  CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    subtotal();
    finaltotal();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CartPage"),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Container(
              height: 845,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...Global.cartProducts
                        .map((e) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 8,
                                child: SizedBox(
                                  height: 130,
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                e['thumbnail'],
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 210,
                                                    child: Text(
                                                      "${e['title']}",
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  // Remove ......................................
                                                  (e['stock']! > 1)
                                                      ? IconButton(
                                                          onPressed: () {
                                                            if (e['stock']! >
                                                                1) {
                                                              e['stock']--;
                                                              subtotal();
                                                              finaltotal();
                                                              setState(() {});
                                                            }
                                                          },
                                                          icon: Icon(
                                                            Icons.remove,
                                                            size: 25,
                                                          ),
                                                        )
                                                      : IconButton(
                                                          disabledColor:
                                                              Colors.black12,
                                                          onPressed: () {},
                                                          icon: Icon(
                                                            Icons.block_flipped,
                                                            size: 25,
                                                          ),
                                                        ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    height: 30,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(20),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      '${e['stock']}',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ),
                                                  // Add ......................................
                                                  if (e['stock']! < 10)
                                                    IconButton(
                                                      onPressed: () {
                                                        if (e['stock']! < 10) {
                                                          e['stock']++;
                                                          subtotal();
                                                          finaltotal();
                                                          setState(() {});
                                                        }
                                                      },
                                                      icon: Icon(
                                                        Icons.add,
                                                        size: 25,
                                                      ),
                                                    )
                                                  else
                                                    IconButton(
                                                      disabledColor:
                                                          Colors.black12,
                                                      onPressed: () {},
                                                      icon: Icon(
                                                        Icons.block_flipped,
                                                        size: 25,
                                                      ),
                                                    ),
                                                  Spacer(),
                                                  IconButton(
                                                      onPressed: () {
                                                        Global.cartProducts
                                                            .remove(e);
                                                        subtotal();
                                                        finaltotal();
                                                        setState(() {});
                                                      },
                                                      icon: Icon(
                                                        Icons.delete,
                                                        size: 30,
                                                        color: Colors.red,
                                                      ))
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "\$ ${e['price']}",
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Product Total : ${e['subTotal'] = (e['price']! * e['stock']!)}',
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.redAccent,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 260,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(50),
                        ),
                        color: Colors.black12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 40,
                              ),
                              Text(
                                'Sub Total : ',
                                style: const TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '${Global.subsum}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.redAccent,
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                          Spacer(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 40,
                              ),
                              Text(
                                'Discount (-5%)  : ',
                                style: const TextStyle(
                                  fontSize: 23,
                                ),
                              ),
                              SizedBox(
                                width: 70,
                              ),
                              Text(
                                '${Global.discount}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.redAccent,
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                          Spacer(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 40,
                              ),
                              Text(
                                'Delivery : ',
                                style: const TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                              SizedBox(
                                width: 125,
                              ),
                              Text(
                                '${Global.delivery}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.redAccent,
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                          Spacer(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 40,
                              ),
                              Text(
                                'Final Total : ',
                                style: const TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '${Global.finalsum}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.redAccent,
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                          Spacer(),
                          Container(
                            color: Colors.brown,
                            height: 50,
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('invoice');
                              },
                              child: Text(
                                'Checkout',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void finaltotal() {
    Global.finalsum = 0;
    Global.cartProducts.forEach((element) {
      var p = element["price"];
      var q = element["stock"];
      var sum = element["price"] * element["stock"];
      setState(() {});
      Global.finalsum = Global.finalsum + sum;
    });
    Global.finalsum = Global.finalsum + Global.delivery - Global.discount;
    setState(() {});
  }

  void subtotal() {
    Global.subsum = 0;
    Global.cartProducts.forEach((element) {
      var p = element["price"];
      var q = element["quantity"];
      var sum = element["price"] * element["stock"];
      Global.subsum = Global.subsum + sum;
    });
    Global.discount = (5 * Global.subsum) / 100;
    setState(() {});
  }
}
