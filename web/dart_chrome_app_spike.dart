import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';
import 'package:chrome/chrome_app.dart' as chrome;

int boundsChange = 100;

/**
 * A `hello world` application for Chrome Apps written in Dart.
 * 
 * Playing with StageXL
 *
 *
 * For more information, see:
 * - http://developer.chrome.com/apps/api_index.html
 * - https://github.com/dart-gde/chrome.dart
 * - http://www.stagexl.org/docs/getting-started.html
 */

void main() {

  // querySelector("#text_id").onClick.listen(resizeWindow);
  
  // setup the Stage and RenderLoop
  var canvas = html.querySelector('#stage');
  var stage = new Stage(canvas);
  var renderLoop = new RenderLoop();
  renderLoop.addStage(stage);
  
  var juggler = renderLoop.juggler; 
 
  // Geometry
  var shape = new Shape();
  
  // Draw a path to form a cloud.
  shape.graphics.beginPath();
  shape.graphics.moveTo(170, 80);
  shape.graphics.bezierCurveTo(130, 100, 130, 150, 230, 150);
  shape.graphics.bezierCurveTo(250, 180, 320, 180, 340, 150);
  shape.graphics.bezierCurveTo(420, 150, 420, 120, 390, 100);
  shape.graphics.bezierCurveTo(430, 40, 370, 30, 340, 50);
  shape.graphics.bezierCurveTo(320, 5, 250, 20, 250, 50);
  shape.graphics.bezierCurveTo(200, 5, 150, 20, 170, 80);
  shape.graphics.closePath();
  
  // Fill and Stroke the path.
  // Note: unlike in Flash, these must be placed after, not before your paths
  shape.graphics.fillColor(0xFF8ED6FF);
  shape.graphics.strokeColor(Color.Blue, 5);

  stage.addChild(shape);
  
  var tween = new Tween(shape, 2.0, TransitionFunction.easeInCubic);
  tween.animate.x.to(380);
  tween.animate.y.to(300);
  tween.onStart = () => print('tween start');   
  tween.onComplete = () => juggler.tween(shape, 2.0, TransitionFunction.sine)
                          ..animate.x.to(0)
                          ..animate.y.to(100); 
//  tween.delay = 0.5;   
  juggler.add(tween);
  
}

void resizeWindow(MouseEvent event) {
  chrome.Bounds bounds = chrome.app.window.current().getBounds();

  bounds.width += boundsChange;
  bounds.left -= boundsChange ~/ 2;

  chrome.app.window.current().setBounds(bounds);

  boundsChange *= -1;
}
