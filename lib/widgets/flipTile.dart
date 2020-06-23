import 'package:flutter/material.dart';
import 'package:flutter_flip_view/flutter_flip_view.dart';
import 'package:hexcolor/hexcolor.dart';

class FlipCard extends StatefulWidget {
  FlipCard({Key key, @required this.question, this.answer}) : super(key: key);

  final String question;
  final String answer;

  @override
  _FlipCardState createState() => _FlipCardState(this.question, this.answer);
}

class _FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  _FlipCardState(this.question, this.answer);

  final String question;
  final String answer;

  AnimationController _animationController;
  Animation<double> _curvedAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _curvedAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _flip(bool reverse) {
    if (_animationController.isAnimating) return;
    if (reverse) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlipView(
      animationController: _curvedAnimation,
      front: _buildCard(question, () => _flip(true)),
      back: _buildCard(answer, () => _flip(false)),
    );
  }

  Widget _buildCard(String title, GestureTapCallback onTap) {
    return Container(
      width: 200,
      height: 100,
      child: Card(
        elevation: 4,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            gradient: LinearGradient(
              colors: [
                Hexcolor('#FFF1BA'),
                Hexcolor('#F4AA33'),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.white.withOpacity(0.1),
              highlightColor: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              onTap: onTap,
              child: Center(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
