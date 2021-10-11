import 'package:flutter/material.dart';

class FlowMenu extends StatefulWidget {
  const FlowMenu({
    Key? key,
    required this.menuItems,
    this.selectedColor = Colors.green,
    // required this.singleItem,
    // required this.onItemClicked,
    this.animMillisec = 350,
  }) : super(key: key);

  final List<IconData> menuItems;
  final int animMillisec;
  final Color selectedColor;
  // final Widget singleItem;
  // final Function() onItemClicked;

  @override
  State<FlowMenu> createState() => _FlowMenuState();
}

class _FlowMenuState extends State<FlowMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController menuAnimation;
  IconData? lastTapped;

  void _updateMenu(IconData icon) {
    if (icon != Icons.menu) {
      setState(() => lastTapped = icon);
    }
  }

  @override
  void initState() {
    super.initState();
    menuAnimation = AnimationController(
      duration: Duration(
        milliseconds: widget.animMillisec,
      ),
      vsync: this,
    );
  }

  Widget flowMenuItem(IconData icon) {
    const double margin = 5.0;
    final itemsCount = widget.menuItems.length;
    final double buttonDiameter =
        (MediaQuery.of(context).size.width / itemsCount) - margin * 2;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      margin: const EdgeInsets.symmetric(horizontal: margin),
      child: RawMaterialButton(
        fillColor: Colors.white,
        elevation: 0.5,
        splashColor: widget.selectedColor,
        shape: const CircleBorder(),
        constraints: BoxConstraints.tight(Size(buttonDiameter, buttonDiameter)),
        onPressed: () {
          _updateMenu(icon);
          menuAnimation.status == AnimationStatus.completed
              ? menuAnimation.reverse()
              : menuAnimation.forward();
        },
        child: FittedBox(
          fit: BoxFit.fill,
          child: Icon(
            icon,
            color: lastTapped == icon ? widget.selectedColor : Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: FlowMenuDelegate(menuAnimation: menuAnimation),
      children: widget.menuItems
          .map<Widget>((IconData icon) => flowMenuItem(icon))
          .toList(),
    );
  }
}

class FlowMenuDelegate extends FlowDelegate {
  FlowMenuDelegate({required this.menuAnimation})
      : super(repaint: menuAnimation);

  final Animation<double> menuAnimation;

  @override
  bool shouldRepaint(FlowMenuDelegate oldDelegate) =>
      menuAnimation != oldDelegate.menuAnimation;

  @override
  void paintChildren(FlowPaintingContext context) {
    double dx = 0.0;
    for (int i = 0; i < context.childCount; ++i) {
      dx = context.getChildSize(i)!.width * i;
      context.paintChild(
        i,
        transform: Matrix4.translationValues(
          dx * menuAnimation.value,
          0,
          0,
        ),
      );
    }
  }
}
