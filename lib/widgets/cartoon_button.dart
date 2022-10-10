import 'package:flutter/material.dart';
import 'package:zaynabiyat/k_constants.dart';

class CartoonButton extends StatefulWidget {
  const CartoonButton({super.key, this.function});
  final void Function(TapUpDetails)? function;

  @override
  State<CartoonButton> createState() => _CartoonButtonState();
}

class _CartoonButtonState extends State<CartoonButton>
    with SingleTickerProviderStateMixin {
  late Animation animationOfPosition;
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: (const Duration(milliseconds: 100)));
    animationOfPosition = Tween(begin: 13.0, end: 20.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool pressed = false;
  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => GestureDetector(
          onTapUp:  widget.function ,
          onTap: () {
            setState(() {
              _controller.forward().then((_) => _controller.reverse());
            });
          },
          child: SizedBox(
            height: 100,
            child: Stack(children: [
              Positioned(
                top: 20,
                right: 45,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(38)),
                    width: 320,
                    height: 75,
                  ),
                ),
              ),
              Positioned(
                top: animationOfPosition.value,
                left: 5,
                right: 5,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    width: 320,
                    height: 75,
                    decoration: kYellowButtonDecoration,
                    child: Center(
                      child: Text(
                        'عرض جميع القصص',
                        style: TextStyle(fontFamily: kElMessiri, fontSize: 24),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      );
}
