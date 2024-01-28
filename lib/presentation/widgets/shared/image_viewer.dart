import 'package:flutter/material.dart';

//https://pub.dev/packages/insta_image_viewer
const _kRouteDuration = Duration(milliseconds: 300);

class ImageViewer extends StatelessWidget {
  const ImageViewer({
    required this.child,
    super.key,
    this.backgroundColor = Colors.black,
    this.disposeLevel,
  });

  final Widget child;
  final Color backgroundColor;
  final DisposeLevel? disposeLevel;

  @override
  Widget build(BuildContext context) {
    final tag = UniqueKey();
    return Hero(
      tag: tag,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              opaque: false,
              barrierColor: backgroundColor,
              pageBuilder: (BuildContext context, _, __) {
                return FullScreenViewer(
                  tag: tag,
                  backgroundColor: backgroundColor,
                  disposeLevel: disposeLevel,
                  child: child,
                );
              },
            ),
          );
        },
        child: child,
      ),
    );
  }
}

enum DisposeLevel { high, medium, low }

class FullScreenViewer extends StatefulWidget {
  const FullScreenViewer({
    required this.child,
    required this.tag,
    super.key,
    this.backgroundColor = Colors.black,
    this.disposeLevel = DisposeLevel.high,
  });

  final Widget child;
  final Color backgroundColor;
  final DisposeLevel? disposeLevel;
  final UniqueKey tag;

  @override
  FullScreenViewerState createState() => FullScreenViewerState();
}

class FullScreenViewerState extends State<FullScreenViewer> {
  double? initialPositionY = 0;

  double? currentPositionY = 0;

  double _positionYDelta = 0;

  double _disposeLimit = 150;

  Duration _animationDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    setDisposeLevel();
  }

  void setDisposeLevel() {
    if (widget.disposeLevel == DisposeLevel.high) {
      _disposeLimit = 300;
    } else if (widget.disposeLevel == DisposeLevel.medium) {
      _disposeLimit = 200;
    } else {
      _disposeLimit = 100;
    }
  }

  void _dragUpdate(DragUpdateDetails details) {
    setState(() {
      currentPositionY = details.globalPosition.dy;
      _positionYDelta = currentPositionY! - initialPositionY!;
    });
  }

  void _dragStart(DragStartDetails details) {
    setState(() {
      initialPositionY = details.globalPosition.dy;
    });
  }

  void _dragEnd(DragEndDetails details) {
    if (_positionYDelta > _disposeLimit || _positionYDelta < -_disposeLimit) {
      Navigator.of(context).pop();
    } else {
      setState(() {
        _animationDuration = _kRouteDuration;
        _positionYDelta = 0;
      });

      Future.delayed(_animationDuration).then((_) {
        setState(() {
          _animationDuration = Duration.zero;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Hero(
      transitionOnUserGestures: true,
      tag: widget.tag,
      child: GestureDetector(
        onVerticalDragUpdate: _dragUpdate,
        onVerticalDragStart: _dragStart,
        onVerticalDragEnd: _dragEnd,
        child: Container(
          color: widget.backgroundColor,
          constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Transform.translate(
                offset: Offset(0, _positionYDelta),
                child: widget.child,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 60, 30, 0),
                  child: ClipOval(
                    child: Material(
                      color: colors.background,
                      child: InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: const SizedBox(
                          width: 40,
                          height: 40,
                          child: Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
