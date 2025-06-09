import 'package:flutter/material.dart';


class CustomCurvedBottomNavBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomCurvedBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  State<CustomCurvedBottomNavBar> createState() =>
      _CustomCurvedBottomNavBarState();
}

class _CustomCurvedBottomNavBarState extends State<CustomCurvedBottomNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _yoloPayAnimationController;
  late Animation<double> _yoloPayScaleAnimation;

  @override
  void initState() {
    super.initState();
    _yoloPayAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _yoloPayScaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _yoloPayAnimationController,
        curve: Curves.easeOutBack,
      ),
    );

    if (widget.selectedIndex == 1) {
      _yoloPayAnimationController.forward();
    }
  }

  @override
  void didUpdateWidget(covariant CustomCurvedBottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      if (widget.selectedIndex == 1) {
        _yoloPayAnimationController.forward(from: 0.0);
      } else {
        _yoloPayAnimationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _yoloPayAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final navBarHeight = 100.0; // Height of the nav bar area
    final curveHeight = 30.0; // Defines the height of the curve's peak

    return Container(
      width: size.width,
      height: navBarHeight,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 0, 0, 0), 
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Custom Painter for the curved background
          CustomPaint(
            size: Size(size.width, navBarHeight),
            painter: _CurvedNavBarPainter(
              curveHeight: curveHeight, 
              backgroundColor: const Color(0xFF1E1E1E),
            ),
          ),
       
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: navBarHeight - 10, // Adjust to position items correctly
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildNavItem(
                  context,
                  icon: Icons.home_outlined,
                  label: 'home',
                  index: 0,
                  isActive: widget.selectedIndex == 0,
                  animation: null,
                ),
                _buildNavItem(
                  context,
                  icon: Icons.qr_code_outlined,
                  label: 'yolo pay',
                  index: 1,
                  isActive: widget.selectedIndex == 1,
                  animation: _yoloPayScaleAnimation,
                ),
                _buildNavItem(
                  context,
                  icon: Icons.percent_outlined,
                  label: 'ginle',
                  index: 2,
                  isActive: widget.selectedIndex == 2,
                  animation: null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required int index,
    required bool isActive,
    Animation<double>? animation,
  }) {
    final bool isYoloPay = (index == 1);
    final iconColor = isActive ? Colors.white : Colors.white.withOpacity(0.5);
    final labelColor = isActive ? Colors.white : Colors.white.withOpacity(0.5);

    Widget itemContent = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isYoloPay)
          AnimatedBuilder(
            animation: animation!,
            builder: (context, child) {
              return Transform.scale(
                scale: animation.value,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isActive
                        ? Colors.white.withOpacity(0.1)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isActive
                          ? Colors.white
                          : Colors.white.withOpacity(0.5),
                      width: isActive ? 1.0 : 0.5,
                    ),
                  ),
                  child: Icon(
                    icon,
                    size: isActive ? 28 : 24,
                    color: iconColor,
                  ),
                ),
              );
            },
          )
        else
          Icon(
            icon,
            size: 24,
            color: iconColor,
            
            
          ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: labelColor,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            
          ),
          
        ),
      ],
    );

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => widget.onItemTapped(index), // Use widget.onItemTapped
          splashColor: Colors.white.withOpacity(0.1),
          highlightColor: Colors.transparent,
          child: Center(
            child: itemContent,
          ),
        ),
      ),
    );
  }
}

// Custom Painter for the curved shape
class _CurvedNavBarPainter extends CustomPainter {
  final double curveHeight;
  final Color backgroundColor;

  _CurvedNavBarPainter({required this.curveHeight, required this.backgroundColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = backgroundColor;
    final path = Path();

    path.moveTo(0, size.height);
    
    path.lineTo(0, curveHeight);


    path.quadraticBezierTo(
      size.width / 2,   
      -curveHeight,     
      size.width,     
      curveHeight      
    );

    path.lineTo(size.width, size.height);
 
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _CurvedNavBarPainter oldDelegate) {

    return oldDelegate.curveHeight != curveHeight ||
           oldDelegate.backgroundColor != backgroundColor;
  }
}
