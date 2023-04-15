import 'package:dsix/model/combat/position.dart';
import 'package:dsix/model/spawner/spawner.dart';
import 'package:dsix/model/combat/temp_position.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/model/map/buttons/map_circular_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CreatorViewSpawnerSprite extends StatefulWidget {
  final Spawner spawner;
  const CreatorViewSpawnerSprite({super.key, required this.spawner});

  @override
  State<CreatorViewSpawnerSprite> createState() =>
      _CreatorViewSpawnerSpriteState();
}

class _CreatorViewSpawnerSpriteState extends State<CreatorViewSpawnerSprite> {
  final SpawnerSpriteController _controller = SpawnerSpriteController();

  void localRefresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _controller.initializeTempPosition(widget.spawner.position);

    return ChangeNotifierProxyProvider<Spawner, TempPosition>(
        create: (context) => _controller.tempPosition,
        update: (context, _, tempPosition) => tempPosition!..panEnd(),
        child: Positioned(
          left: _controller.tempPosition.newPosition.dx -
              (widget.spawner.size / 2),
          top: _controller.tempPosition.newPosition.dy -
              (widget.spawner.size / 2),
          child: SizedBox(
            width: widget.spawner.size,
            height: widget.spawner.size,
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: AppLayout.avarage(context) * 0.01),
                      child: const SpawnerSpriteImage(),
                    )),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.blue.withAlpha(25),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.blue,
                      width: 0.3,
                    ),
                  ),
                  child: GestureDetector(
                    onPanStart: (details) {
                      _controller.drag = true;
                    },
                    onPanUpdate: (details) {
                      _controller.tempPosition.panUpdate(details.delta, 'tile');
                      localRefresh();
                    },
                    onPanEnd: (details) {
                      _controller.endMove(
                          _controller.tempPosition, widget.spawner);
                    },
                  ),
                ),
                Align(
                    alignment: Alignment.center,
                    child: _controller.getMenu(widget.spawner, localRefresh)),
              ],
            ),
          ),
        ));
  }
}

class SpawnerSpriteController {
  //POSITION

  final TempPosition tempPosition = TempPosition();
  bool drag = false;

  void initializeTempPosition(Position originalPosition) {
    if (drag == false) {
      tempPosition.initialize(originalPosition);
    }
  }

  Offset getPosition(TempPosition tempPosition, Spawner spawner) {
    return Offset(tempPosition.newPosition.dx - spawner.size / 2,
        tempPosition.newPosition.dy - spawner.size / 2);
  }

  void endMove(TempPosition tempPosition, Spawner spawner) {
    spawner.changePosition(tempPosition.newPosition);
    drag = false;
  }

  //INTERNAL UI

  Widget getMenu(Spawner spawner, Function refresh) {
    Widget menu = const SizedBox();

    menu = SizedBox(
      width: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MapCircularButton(
            color: AppColors.uiColor.withAlpha(200),
            iconColor: AppColors.uiColorLight.withAlpha(200),
            borderColor: AppColors.uiColorLight.withAlpha(200),
            icon: AppImages.minus,
            size: 5.0,
            onTap: () {
              spawner.changeSize(-10);
            },
          ),
          MapCircularButton(
            color: AppColors.uiColor.withAlpha(200),
            iconColor: AppColors.uiColorLight.withAlpha(200),
            borderColor: AppColors.uiColorLight.withAlpha(200),
            icon: AppImages.plus,
            size: 5.0,
            onTap: () {
              spawner.changeSize(10);
            },
          ),
        ],
      ),
    );

    return menu;
  }
}

class SpawnerSpriteImage extends StatefulWidget {
  final Duration duration;
  final double deltaY;
  const SpawnerSpriteImage(
      {super.key,
      this.duration = const Duration(milliseconds: 1000),
      this.deltaY = 0.5});

  @override
  State<SpawnerSpriteImage> createState() => _SpawnerSpriteImageState();
}

class _SpawnerSpriteImageState extends State<SpawnerSpriteImage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )
      ..forward()
      ..addListener(() {
        if (controller.isCompleted) {
          controller.repeat();
        }
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  /// convert 0-1 to 0-1-0
  double shake(double value) =>
      2 * (0.5 - (0.5 - Curves.easeInOut.transform(value)).abs());

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => Transform.translate(
        offset: Offset(
          0,
          widget.deltaY * shake(controller.value),
        ),
        child: child,
      ),
      child: SvgPicture.asset(
        AppImages.spawner,
        width: 12,
        color: AppColors.blue,
      ),
    );
  }
}
