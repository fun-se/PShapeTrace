/******************************
*
* tool.pde: The main file of PShapeTrace
*
******************************/


import processing.core.PImage;
import java.util.ArrayList;

/**
 * Records an execution of a drawing instruction
 */
class ShapeRecord {
  String type;
  Object[] params;
  int mode;
  String methodName;
  int lineNumber;
  Transformation transformation;

  ShapeRecord(String type, Object[] params, int mode,
    String methodName, int lineNumber, 
    Transformation transformation) {
    this.type = type;
    this.params = params;
    this.mode = mode;
    this.methodName = methodName;
    this.lineNumber = lineNumber;
    this.transformation = transformation;
  }
  
  ShapeRecord(String type, Object[] params, 
    String methodName, int lineNumber, 
    Transformation transformation) {
    this.type = type;
    this.params = params;
    this.methodName = methodName;
    this.lineNumber = lineNumber;
    this.transformation = transformation;
  }
  
}

/**
 * Represents instructions executed to draw the current frame
 */
ArrayList<ShapeRecord> shapes = new ArrayList<ShapeRecord>();

/**
 * Records clicked shapes to select a shape from overlapping ones
 */
ArrayList<Integer> clickedIndices = new ArrayList<Integer>();

/**
 * Index of the shape whose method name was clicked in the record list.
 * The corresponding method name is highlighted in red and the shape is
 * surrounded by a 1-pixel red outline. -1 means no shape is selected.
 */
int highlightedShapeIndex = -1;



boolean TOOL_DISABLED = false;

void resetShapes() {
  shapes.clear();
}

final int NO_MODE = 0;

void recordShape(Object[] params, int mode) {
  Thread t = Thread.currentThread();
  StackTraceElement[] stack = t.getStackTrace();
  StackTraceElement caller = stack[3];
  StackTraceElement called = stack[2];

  Transformation copyOfCurrentTransformation = null;
  if (!currentTransformation.isIdentity()) {
    copyOfCurrentTransformation = new Transformation(currentTransformation);
  }

  shapes.add(new ShapeRecord(called.getMethodName(), params, mode,
      caller.getMethodName(), caller.getLineNumber(),
      copyOfCurrentTransformation
  ));
}



//--- Methods to override the original behavior of Processing functions ---
// Not implemented: text methods with z cooridnate, rotateX, rotateY, rotateZ, 
// shearX, shearY, applyMatrix, setMatrix, camera-related methods, model methods

@Override
void background(int v1) {
  super.background(v1);
  if (TOOL_DISABLED) return;
  resetShapes();
  recordShape(new Object[]{v1}, NO_MODE);
}

@Override
void background(int rgb, float alpha) {
  super.background(rgb, alpha);
  if (TOOL_DISABLED) return;
  resetShapes();
  recordShape(new Object[]{rgb, alpha}, NO_MODE);
}

@Override
void background(float v1, float v2, float v3) {
  super.background(v1, v2, v3);
  if (TOOL_DISABLED) return;
  resetShapes();
  recordShape(new Object[]{v1, v2, v3}, NO_MODE);
}

@Override
void background(float v1, float v2, float v3, float alpha) {
  super.background(v1, v2, v3, alpha);
  if (TOOL_DISABLED) {
    return;
  }
  resetShapes();
  recordShape(new Object[]{v1, v2, v3, alpha}, NO_MODE);
}

@Override
void background(float gray) {
  super.background(gray);
  if (TOOL_DISABLED) {
    return;
  }
  resetShapes();
  recordShape(new Object[]{gray}, NO_MODE);
}

@Override
void background(float gray, float alpha) {
  super.background(gray, alpha);
  if (TOOL_DISABLED) return;
  resetShapes();
  recordShape(new Object[]{gray, alpha}, NO_MODE);
}

@Override
void background(PImage img) {
  super.background(img);
  if (TOOL_DISABLED) return;
  resetShapes();
  recordShape(new Object[]{img}, NO_MODE);
}

@Override
void text(char c, float x, float y) {
  super.text(c, x, y);
  if (TOOL_DISABLED) return;
  recordShape(new Object[]{c, x, y}, NO_MODE);
}

@Override
void text(String str, float x, float y) {
  super.text(str, x, y);
  if (TOOL_DISABLED) return;
  recordShape(new Object[]{str, x, y}, NO_MODE);
}

@Override
void text(char[] chars, int start, int stop, float x, float y) {
  super.text(chars, start, stop, x, y);
  if (TOOL_DISABLED) return;
  recordShape(new Object[]{chars, start, stop, x, y}, NO_MODE);
}

@Override
void text(String str, float x1, float y1, float x2, float y2) {
  super.text(str, x1, y1, x2, y2); 
  if (TOOL_DISABLED) return;
  recordShape(new Object[]{str, x1, y1, x2, y2}, NO_MODE);
}

@Override
void text(int num, float x, float y) {
  super.text(num, x, y);
  if (TOOL_DISABLED) return;
  recordShape(new Object[]{num, x, y}, NO_MODE);
}

@Override
void text(float num, float x, float y) {
  super.text(num, x, y);
  if (TOOL_DISABLED) return;
  recordShape(new Object[]{num, x, y}, NO_MODE);
}

@Override
void image(PImage img, float x, float y, float w, float h) {
  super.image(img, x, y, w, h);
  if (TOOL_DISABLED) return;
  recordShape(new Object[]{img, x, y, w, h}, imageMode);
}

@Override
void image(PImage img, float x, float y) {
  super.image(img, x, y);
  if (TOOL_DISABLED) return;
  recordShape(new Object[]{img, x, y, img.width, img.height}, imageMode);
}

@Override
void arc(float x, float y, float w, float h, float start, float stop) {
  super.arc(x, y, w, h, start, stop);
  if (TOOL_DISABLED) return;
  recordShape(new Object[]{x, y, w, h, start, stop}, ellipseMode);
}

@Override
void arc(float x, float y, float w, float h, float start, float stop, int mode) {
  super.arc(x, y, w, h, start, stop, mode);
  if (TOOL_DISABLED) return;
  recordShape(new Object[]{x, y, w, h, start, stop, mode}, ellipseMode);
}

@Override
void circle(float x, float y, float d) {
  super.circle(x, y, d);
  if (TOOL_DISABLED) return;
  recordShape(new Object[]{x, y, d}, ellipseMode);
}

@Override
void ellipse(float x, float y, float w, float h) {
  super.ellipse(x, y, w, h);
  if (TOOL_DISABLED) return;
  recordShape(new Object[]{x, y, w, h}, ellipseMode);
}

@Override
void line(float x1, float y1, float x2, float y2) {
  super.line(x1, y1, x2, y2);
  if (TOOL_DISABLED) return;
  recordShape(new Object[]{x1, y1, x2, y2}, NO_MODE);
}

@Override
void point(float x, float y) {
  super.point(x, y);
  if (TOOL_DISABLED) return;
  recordShape(new Object[]{x, y}, NO_MODE);
}

@Override
void quad(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  super.quad(x1, y1, x2, y2, x3, y3, x4, y4);
  if (TOOL_DISABLED) return;
  recordShape(new Object[]{x1, y1, x2, y2, x3, y3, x4, y4}, NO_MODE);
}

@Override
void rect(float x, float y, float w, float h) {
  super.rect(x, y, w, h);
  if (TOOL_DISABLED) return;
  recordShape(new Object[]{x, y, w, h}, rectMode);
}

@Override
void rect(float x, float y, float w, float h, float r) {
  super.rect(x, y, w, h, r);
  if (TOOL_DISABLED) return;
  recordShape(new Object[]{x, y, w, h, r}, rectMode);
}

@Override
void rect(float x, float y, float w, float h, float tl, float tr, float br, float bl) {
  super.rect(x, y, w, h, tl, tr, br, bl);
  if (TOOL_DISABLED) return;
  recordShape(new Object[]{x, y, w, h, tl, tr, br, bl}, rectMode);
}

@Override
void square(float x, float y, float s) {
  super.square(x, y, s);
  if (TOOL_DISABLED) return;
  recordShape(new Object[]{x, y, s}, rectMode);
}

@Override
void triangle(float x1, float y1, float x2, float y2, float x3, float y3) {
  super.triangle(x1, y1, x2, y2, x3, y3);
  if (TOOL_DISABLED) return;
  recordShape(new Object[]{x1, y1, x2, y2, x3, y3}, NO_MODE);
}


@Override
public void size(int x, int y) {
  // Call an original instruction if the tool is disabled 
  if (TOOL_DISABLED) {
    super.size(x, y);
    return;
  }
    
  // Adjust the window size to include the tool's UI
  widthAlt  = x + widthAdd;
  heightAlt = y + heightAdd;
  super.size(widthAlt, heightAlt);
}

@Override
void translate(float tx, float ty) {
  super.translate(tx, ty);
  if (TOOL_DISABLED) return;

  currentTransformation.translateX += tx;
  currentTransformation.translateY += ty;
  transformationsChanged = true;
}

@Override
void scale(float s) {
  super.scale(s);
  if (TOOL_DISABLED) return;

  currentTransformation.scaleX *= s;
  currentTransformation.scaleY *= s;
  transformationsChanged = true;
}

@Override
void scale(float sx, float sy) {
  // Call an original instruction if the tool is disabled 
  if (TOOL_DISABLED) {
    super.scale(sx, sy);
    return;
  }

  if (sx == 0 || sy == 0) {
    return;
  }
  super.scale(sx, sy);
  currentTransformation.scaleX *= sx;
  currentTransformation.scaleY *= sy;
  transformationsChanged = true;
}

@Override
void rotate(float angle) {
  super.rotate(angle);
  if (TOOL_DISABLED) return;

  currentTransformation.rotateAngle += angle;
  transformationsChanged = true;
}

@Override
void resetMatrix() {
  super.resetMatrix();
  if (TOOL_DISABLED) return;
  
  currentTransformation.reset();
}


int rectMode = -1;
int ellipseMode = -1;
int imageMode = -1;

@Override 
void rectMode(int mode) {
  rectMode = mode;
  super.rectMode(mode);
}

@Override
void ellipseMode(int mode) {
  ellipseMode = mode;
  super.ellipseMode(mode);
}

@Override
void imageMode(int mode) {
  imageMode = mode;
  super.imageMode(mode);
}



void draw() {
  // Call an original instruction if the tool is disabled 
  if (TOOL_DISABLED) {
    drawMain();
    return;
  }

  updateMouseState();
  updateKeyState();
  
  if (drawingMode) {
    pushMatrix();
    pushStyle();
    drawMain();
    popMatrix();
    popStyle();
    drawEnd();
  } else {
    extraMode();
  }
  
  searchShapes();
  drawHighlightOutline();
  drawUI();
}

//--- Methods to implement the tool's behavior ---

boolean isPointInText(float px, float py, float tx, float ty, float tw, float th) {
  return px >= tx && px <= tx + tw && py >= ty - th && py <= ty;
}

boolean isPointInRect(float px, float py, float rx, float ry, float rw, float rh) {
  return px >= rx && px <= rx + rw && py >= ry && py <= ry + rh;
}

boolean isPointInEllipse(float px, float py, float cx, float cy, float a, float b) {
  return sq(px - cx) / sq(a) + sq(py - cy) / sq(b) <= 1;
}

float normalizeAngle(float angle) {
    angle = angle % TWO_PI;
    if (angle < 0) angle += TWO_PI;
    return angle;
}

boolean isAngleInArc(float px, float py, float cx, float cy, float start, float stop) {
    float angle = atan2(py - cy, px - cx);
    angle = normalizeAngle(angle);

    start = normalizeAngle(start);
    stop = normalizeAngle(stop);

    float angleDiff = (stop - start + TWO_PI) % TWO_PI;
    float pointDiff = (angle - start + TWO_PI) % TWO_PI;

    return pointDiff <= angleDiff;
}

boolean isPointInPolygon(float x, float y, ArrayList<PVector> polygon) {
    boolean inside = false;
    int n = polygon.size();
    for (int i = 0, j = n - 1; i < n; j = i++) {
        float xi = polygon.get(i).x, yi = polygon.get(i).y;
        float xj = polygon.get(j).x, yj = polygon.get(j).y;

        boolean intersect = ((yi > y) != (yj > y)) &&
            (x < (xj - xi) * (y - yi) / (yj - yi + Float.MIN_VALUE) + xi);
        if (intersect) inside = !inside;
    }
    return inside;
}

boolean isPointInChordArea(float px, float py, float cx, float cy, float rx, float ry, float start, float stop) {
    float x1 = cx + rx * cos(start);
    float y1 = cy + ry * sin(start);
    float x2 = cx + rx * cos(stop);
    float y2 = cy + ry * sin(stop);

    ArrayList<PVector> vertices = new ArrayList<PVector>();
    vertices.add(new PVector(x1, y1));

    int numSegments = 100;
    float angleDiff = (stop - start + TWO_PI) % TWO_PI;
    float angleStep = angleDiff / numSegments;

    for (int i = 1; i < numSegments; i++) {
        float angle = start + i * angleStep;
        angle = normalizeAngle(angle);
        float x = cx + rx * cos(angle);
        float y = cy + ry * sin(angle);
        vertices.add(new PVector(x, y));
    }

    vertices.add(new PVector(x2, y2));
    vertices.add(new PVector(x1, y1));

    return isPointInPolygon(px, py, vertices);
}

boolean isPointInArc(float px, float py, float cx, float cy, float w, float h, float start, float stop, int mode) {
    float rx = w / 2;
    float ry = h / 2;

    boolean isInEllipse = isPointInEllipse(px, py, cx, cy, rx, ry);

    if (!isInEllipse) {
        return false;
    }

    start = normalizeAngle(start);
    stop = normalizeAngle(stop);

    boolean isInAngleRange = isAngleInArc(px, py, cx, cy, start, stop);

    if (mode == PIE) {
        return isInAngleRange;
    } else if (mode == CHORD || mode == OPEN) {
        return isInAngleRange && isPointInChordArea(px, py, cx, cy, rx, ry, start, stop);
    } else {
        return false;
    }
}

boolean isPointInTriangle(float px, float py, float x1, float y1, float x2, float y2, float x3, float y3) {
  float d1, d2, d3;
  boolean hasNeg, hasPos;

  d1 = sign(px, py, x1, y1, x2, y2);
  d2 = sign(px, py, x2, y2, x3, y3);
  d3 = sign(px, py, x3, y3, x1, y1);

  hasNeg = (d1 < 0) || (d2 < 0) || (d3 < 0);
  hasPos = (d1 > 0) || (d2 > 0) || (d3 > 0);

  return !(hasNeg && hasPos);
}

float sign(float x1, float y1, float x2, float y2, float x3, float y3) {
  return (x1 - x3) * (y2 - y3) - (x2 - x3) * (y1 - y3);
}

boolean isPointInQuad(float px, float py, float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  boolean b1, b2;

  b1 = isPointInTriangle(px, py, x1, y1, x2, y2, x3, y3);
  b2 = isPointInTriangle(px, py, x1, y1, x3, y3, x4, y4);

  return b1 || b2;
}

boolean isPointOnLine(float px, float py, float x1, float y1, float x2, float y2) {
  float d1 = dist(px, py, x1, y1);
  float d2 = dist(px, py, x2, y2);
  float lineLen = dist(x1, y1, x2, y2);
  float buffer = 0.1;

  return (d1 + d2 >= lineLen - buffer && d1 + d2 <= lineLen + buffer);
}

boolean isPointOnPoint(float px, float py, float x, float y) {
  float buffer = 5;
  return dist(px, py, x, y) <= buffer;
}

void searchShapes() {
  if (customMousePressed) {
    if (mouseXAlt < 0 || mouseXAlt > width || mouseYAlt < 0 || mouseYAlt > height) {

      return;
    }
    
    SavedFrame frame = savedShapes[currentFrameIndex];
    for (int i = frame.shapes.size() - 1; i >= 0; i--) {
      if (clickedIndices.contains(i)) {
        continue;
      }
      ShapeRecord shape = frame.shapes.get(i);
      boolean hit = false;
      
      float transformedMouseX = mouseX;
      float transformedMouseY = mouseY;
      if (shape.transformation != null) {
        PVector transformedMouse = applyInverseTransformation(shape.transformation, transformedMouseX, transformedMouseY);
        transformedMouseX = transformedMouse.x;
        transformedMouseY = transformedMouse.y;
      }
      
      switch (shape.type) {
        case "text":
          float tw = textWidth(shape.params[0].toString());
          float th = textAscent() + textDescent();
          hit = isPointInText(
            transformedMouseX, transformedMouseY,
            ((Number) shape.params[1]).floatValue(),
            ((Number) shape.params[2]).floatValue(),
            tw, th);
          break;
        case "image":
          float ix = ((Number) shape.params[0]).floatValue();
          float iy = ((Number) shape.params[1]).floatValue();
          float iw = ((Number) shape.params[2]).floatValue();
          float ih = ((Number) shape.params[3]).floatValue();
          
          switch (shape.mode) {
            case CORNER:
            default:
            break;
            case CORNERS:
              float x1 = Math.min(ix, iw);
              float y1 = Math.min(iy, ih);
              float x2 = Math.max(ix, iw);
              float y2 = Math.max(iy, ih);
              ix = x1;
              iy = y1;
              iw = x2 - x1;
              ih = y2 - y1;
            break;
            case CENTER:
              ix -= iw / 2;
              iy -= ih / 2;
            break;
          }
          hit = isPointInRect(
            transformedMouseX, transformedMouseY,
            ix, iy, iw, ih);
          break;
        case "arc":
          float ax = ((Number) shape.params[0]).floatValue();
          float ay = ((Number) shape.params[1]).floatValue();
          float aw = ((Number) shape.params[2]).floatValue();
          float ah = ((Number) shape.params[3]).floatValue();
          float start = ((Number) shape.params[4]).floatValue();
          float stop = ((Number) shape.params[5]).floatValue();
          int mode = (shape.params.length == 7) ? (int) shape.params[6] : PIE;
          
          switch (shape.mode) {
            case CENTER:
            default:
            break;
            case RADIUS:
              aw *= 2;
              ah *= 2;
            break;
            case CORNER:
              ax += aw / 2;
              ay += ah / 2;
            break;
            case CORNERS:
              float minX = Math.min(ax, aw);
              float minY = Math.min(ay, ah);
              float maxX = Math.max(ax, aw);
              float maxY = Math.max(ay, ah);
              aw = maxX - minX;
              ah = maxY - minY;
              ax = minX + aw / 2;
              ay = minY + ah / 2;
            break;
          }
          hit = isPointInArc(
            transformedMouseX, transformedMouseY,
            ax, ay, aw, ah, start, stop, mode);
          break;
        case "circle":
          float cx = ((Number) shape.params[0]).floatValue();
          float cy = ((Number) shape.params[1]).floatValue();
          float cw = ((Number) shape.params[2]).floatValue();
          float ch = cw;
          
          switch (shape.mode) {
            case CENTER:
            default:
            break;
            case RADIUS:
              cw *= 2;
              ch *= 2;
            break;
            case CORNER:
              cx += cw / 2;
              cy += cw / 2;
            break;
            case CORNERS:
              float minX = Math.min(cx, cw);
              float minY = Math.min(cy, ch);
              float maxX = Math.max(cx, cw);
              float maxY = Math.max(cy, ch);
              cw = maxX - minX;
              ch = maxY - minY;
              cx = minX + cw / 2;
              cy = minY + ch / 2;
            break;
          }
          hit = isPointInEllipse(
            transformedMouseX, transformedMouseY,
            cx, cy, cw / 2, ch / 2);
          break;
        case "ellipse":
          float ex = ((Number) shape.params[0]).floatValue();
          float ey = ((Number) shape.params[1]).floatValue();
          float ew = ((Number) shape.params[2]).floatValue();
          float eh = ((Number) shape.params[3]).floatValue();
          
          switch (shape.mode) {
            case CENTER:
            default:
            break;
            case RADIUS:
              ew *= 2;
              eh *= 2;
            break;
            case CORNER:
              ex += ew / 2;
              ey += eh / 2;
            break;
            case CORNERS:
              float minX = Math.min(ex, ew);
              float minY = Math.min(ey, eh);
              float maxX = Math.max(ex, ew);
              float maxY = Math.max(ey, eh);
              ew = maxX - minX;
              eh = maxY - minY;
              ex = minX + ew / 2;
              ey = minY + eh / 2;
            break;
          }
          hit = isPointInEllipse(
            transformedMouseX, transformedMouseY,
            ex, ey, ew / 2, eh / 2);
          break;
        case "line":
          hit = isPointOnLine(
            transformedMouseX, transformedMouseY,
            ((Number) shape.params[0]).floatValue(),
            ((Number) shape.params[1]).floatValue(),
            ((Number) shape.params[2]).floatValue(),
            ((Number) shape.params[3]).floatValue());
          break;
        case "point":
          hit = isPointOnPoint(
            transformedMouseX, transformedMouseY,
            ((Number) shape.params[0]).floatValue(),
            ((Number) shape.params[1]).floatValue());
          break;
        case "quad":
          hit = isPointInQuad(
            transformedMouseX, transformedMouseY,
            ((Number) shape.params[0]).floatValue(),
            ((Number) shape.params[1]).floatValue(),
            ((Number) shape.params[2]).floatValue(),
            ((Number) shape.params[3]).floatValue(),
            ((Number) shape.params[4]).floatValue(),
            ((Number) shape.params[5]).floatValue(),
            ((Number) shape.params[6]).floatValue(),
            ((Number) shape.params[7]).floatValue());
          break;
        case "rect":
          float rx = ((Number) shape.params[0]).floatValue();
          float ry = ((Number) shape.params[1]).floatValue();
          float rw = ((Number) shape.params[2]).floatValue();
          float rh = ((Number) shape.params[3]).floatValue();
          
          switch (shape.mode) {
            case CORNER:
            default:
            break;
            case CORNERS:
              float x1 = Math.min(rx, rw);
              float y1 = Math.min(ry, rh);
              float x2 = Math.max(rx, rw);
              float y2 = Math.max(ry, rh);
              rx = x1;
              ry = y1;
              rw = x2 - x1;
              rh = y2 - y1;
            break;
            case CENTER:
              rx -= rw / 2;
              ry -= rh / 2;
            break;
            case RADIUS:
              rx -= rw;
              ry -= rh;
              rw *= 2;
              rh *= 2;
            break;
          }
          hit = isPointInRect(
            transformedMouseX, transformedMouseY,
            rx, ry, rw, rh);
          break;
        case "square":
          float sx = ((Number) shape.params[0]).floatValue();
          float sy = ((Number) shape.params[1]).floatValue();
          float sw = ((Number) shape.params[2]).floatValue();
          float sh = sw;
      
          switch (shape.mode) {
            case CORNER:
            default:
            break;
            case CORNERS:
              float x1 = Math.min(sx, sw);
              float y1 = Math.min(sy, sh);
              float x2 = Math.max(sx, sw);
              float y2 = Math.max(sy, sh);
              sx = x1;
              sy = y1;
              sw = x2 - x1;
              sh = y2 - y1;
            break;
            case CENTER:
              sx -= sw / 2;
              sy -= sw / 2;
            break;
            case RADIUS:
              sx -= sw;
              sy -= sw;
              sw *= 2;
              sh *= 2;
            break;
          }
          hit = isPointInRect(
            transformedMouseX, transformedMouseY,
            sx, sy, sw, sh);
          break;
        case "triangle":
          hit = isPointInTriangle(
            transformedMouseX, transformedMouseY,
            ((Number) shape.params[0]).floatValue(),
            ((Number) shape.params[1]).floatValue(),
            ((Number) shape.params[2]).floatValue(),
            ((Number) shape.params[3]).floatValue(),
            ((Number) shape.params[4]).floatValue(),
            ((Number) shape.params[5]).floatValue());
          break;
        default:
          break;
      }
      if (hit) {

        clickedIndices.add(i);
        highlightedShapeIndex = i;
        return;
      }
    }

    clickedIndices.clear();
    // No shape was hit: select the background, which fills the whole canvas.
    highlightedShapeIndex = -1;
    for (int i = 0; i < frame.shapes.size(); i++) {
      if (frame.shapes.get(i).type.equals("background")) {
        highlightedShapeIndex = i;
        break;
      }
    }
  }
}

PVector applyInverseTransformation(Transformation trans, float x, float y) {
  float sinAngle = sin(-trans.rotateAngle);
  float cosAngle = cos(-trans.rotateAngle);
  float x1 = x * cosAngle - y * sinAngle;
  float y1 = x * sinAngle + y * cosAngle;

  float x2 = x1 / trans.scaleX;
  float y2 = y1 / trans.scaleY;

  float x3 = x2 - trans.translateX;
  float y3 = y2 - trans.translateY;

  return new PVector(x3, y3);
}

/**
 * Draws a 1-pixel red outline around the shape selected by clicking
 * its method name in the record list.
 */
void drawHighlightOutline() {
  if (highlightedShapeIndex < 0 || totalFrames == 0) return;

  SavedFrame frame = savedShapes[currentFrameIndex];
  if (frame == null || highlightedShapeIndex >= frame.shapes.size()) {
    highlightedShapeIndex = -1;
    return;
  }

  ShapeRecord shape = frame.shapes.get(highlightedShapeIndex);
  if (shape.type.equals("background")) return;

  pushMatrix();
  pushStyle();

  colorMode(RGB, 255, 255, 255);
  noFill();
  stroke(255, 0, 0);
  // Use super.* so the tool's transformation/mode bookkeeping is untouched.
  super.rectMode(CORNER);
  super.ellipseMode(CENTER);

  // Reproduce the same forward transformation assumed by
  // applyInverseTransformation (rotate, then scale, then translate).
  float sc = 1;
  if (shape.transformation != null) {
    Transformation t = shape.transformation;
    super.rotate(t.rotateAngle);
    super.scale(t.scaleX, t.scaleY);
    super.translate(t.translateX, t.translateY);
    sc = max(abs(t.scaleX), abs(t.scaleY));
    if (sc == 0) sc = 1;
  }

  // Keep the stroke and the outward margin at roughly 1 pixel on screen
  // even when a scale transformation is active.
  strokeWeight(1.0 / sc);
  float m = 1.0 / sc;

  drawShapeOutline(shape, m);

  popStyle();
  popMatrix();
}

float num(Object o) {
  return ((Number) o).floatValue();
}

/**
 * Draws the outline of a single shape expanded outward by margin m,
 * mirroring the coordinate/mode handling used in searchShapes().
 */
void drawShapeOutline(ShapeRecord shape, float m) {
  switch (shape.type) {
    case "rect": {
      float rx = num(shape.params[0]);
      float ry = num(shape.params[1]);
      float rw = num(shape.params[2]);
      float rh = num(shape.params[3]);
      switch (shape.mode) {
        case CORNER:
        default:
          break;
        case CORNERS:
          float x1 = min(rx, rw), y1 = min(ry, rh);
          float x2 = max(rx, rw), y2 = max(ry, rh);
          rx = x1; ry = y1; rw = x2 - x1; rh = y2 - y1;
          break;
        case CENTER:
          rx -= rw / 2; ry -= rh / 2;
          break;
        case RADIUS:
          rx -= rw; ry -= rh; rw *= 2; rh *= 2;
          break;
      }
      super.rect(rx - m, ry - m, rw + 2 * m, rh + 2 * m);
      break;
    }
    case "square": {
      float sx = num(shape.params[0]);
      float sy = num(shape.params[1]);
      float sw = num(shape.params[2]);
      float sh = sw;
      switch (shape.mode) {
        case CORNER:
        default:
          break;
        case CORNERS:
          float x1 = min(sx, sw), y1 = min(sy, sh);
          float x2 = max(sx, sw), y2 = max(sy, sh);
          sx = x1; sy = y1; sw = x2 - x1; sh = y2 - y1;
          break;
        case CENTER:
          sx -= sw / 2; sy -= sw / 2;
          break;
        case RADIUS:
          sx -= sw; sy -= sw; sw *= 2; sh *= 2;
          break;
      }
      super.rect(sx - m, sy - m, sw + 2 * m, sh + 2 * m);
      break;
    }
    case "image": {
      float ix = num(shape.params[1]);
      float iy = num(shape.params[2]);
      float iw = num(shape.params[3]);
      float ih = num(shape.params[4]);
      switch (shape.mode) {
        case CORNER:
        default:
          break;
        case CORNERS:
          float x1 = min(ix, iw), y1 = min(iy, ih);
          float x2 = max(ix, iw), y2 = max(iy, ih);
          ix = x1; iy = y1; iw = x2 - x1; ih = y2 - y1;
          break;
        case CENTER:
          ix -= iw / 2; iy -= ih / 2;
          break;
      }
      super.rect(ix - m, iy - m, iw + 2 * m, ih + 2 * m);
      break;
    }
    case "circle": {
      float cx = num(shape.params[0]);
      float cy = num(shape.params[1]);
      float cw = num(shape.params[2]);
      float ch = cw;
      switch (shape.mode) {
        case CENTER:
        default:
          break;
        case RADIUS:
          cw *= 2; ch *= 2;
          break;
        case CORNER:
          cx += cw / 2; cy += cw / 2;
          break;
        case CORNERS:
          float minX = min(cx, cw), minY = min(cy, ch);
          float maxX = max(cx, cw), maxY = max(cy, ch);
          cw = maxX - minX; ch = maxY - minY;
          cx = minX + cw / 2; cy = minY + ch / 2;
          break;
      }
      super.ellipse(cx, cy, cw + 2 * m, ch + 2 * m);
      break;
    }
    case "ellipse": {
      float ex = num(shape.params[0]);
      float ey = num(shape.params[1]);
      float ew = num(shape.params[2]);
      float eh = num(shape.params[3]);
      switch (shape.mode) {
        case CENTER:
        default:
          break;
        case RADIUS:
          ew *= 2; eh *= 2;
          break;
        case CORNER:
          ex += ew / 2; ey += eh / 2;
          break;
        case CORNERS:
          float minX = min(ex, ew), minY = min(ey, eh);
          float maxX = max(ex, ew), maxY = max(ey, eh);
          ew = maxX - minX; eh = maxY - minY;
          ex = minX + ew / 2; ey = minY + eh / 2;
          break;
      }
      super.ellipse(ex, ey, ew + 2 * m, eh + 2 * m);
      break;
    }
    case "arc": {
      float ax = num(shape.params[0]);
      float ay = num(shape.params[1]);
      float aw = num(shape.params[2]);
      float ah = num(shape.params[3]);
      float start = num(shape.params[4]);
      float stop = num(shape.params[5]);
      int mode = (shape.params.length == 7) ? (int) shape.params[6] : PIE;
      switch (shape.mode) {
        case CENTER:
        default:
          break;
        case RADIUS:
          aw *= 2; ah *= 2;
          break;
        case CORNER:
          ax += aw / 2; ay += ah / 2;
          break;
        case CORNERS:
          float minX = min(ax, aw), minY = min(ay, ah);
          float maxX = max(ax, aw), maxY = max(ay, ah);
          aw = maxX - minX; ah = maxY - minY;
          ax = minX + aw / 2; ay = minY + ah / 2;
          break;
      }
      super.arc(ax, ay, aw + 2 * m, ah + 2 * m, start, stop, mode);
      break;
    }
    case "line":
      super.line(num(shape.params[0]), num(shape.params[1]),
                 num(shape.params[2]), num(shape.params[3]));
      break;
    case "point":
      super.ellipse(num(shape.params[0]), num(shape.params[1]),
                    10 + 2 * m, 10 + 2 * m);
      break;
    case "triangle":
      super.triangle(num(shape.params[0]), num(shape.params[1]),
                     num(shape.params[2]), num(shape.params[3]),
                     num(shape.params[4]), num(shape.params[5]));
      break;
    case "quad":
      super.quad(num(shape.params[0]), num(shape.params[1]),
                 num(shape.params[2]), num(shape.params[3]),
                 num(shape.params[4]), num(shape.params[5]),
                 num(shape.params[6]), num(shape.params[7]));
      break;
    case "text": {
      float tx = num(shape.params[1]);
      float ty = num(shape.params[2]);
      float tw = textWidth(shape.params[0].toString());
      float th = textAscent() + textDescent();
      super.rect(tx - m, ty - th - m, tw + 2 * m, th + 2 * m);
      break;
    }
    default:
      break;
  }
}

int currentFrameIndex = 0;

void changeFrame() {
  if (!drawingMode) {
    if (keyCode == LEFT || keyCode == RIGHT || keyCode == UP || keyCode == DOWN) {
      highlightedShapeIndex = -1;
    }
    if (keyCode == LEFT) {
      currentFrameIndex = (currentFrameIndex - 1 + MAX_FRAME) % MAX_FRAME;
    }
    else if (keyCode == RIGHT) {
      currentFrameIndex = (currentFrameIndex + 1) % MAX_FRAME;
    }
    else if (keyCode == DOWN) {
      currentFrameIndex = (currentFrameIndex - 10 + MAX_FRAME) % MAX_FRAME;
    }
    else if (keyCode == UP) {
      currentFrameIndex = (currentFrameIndex + 10) % MAX_FRAME;
    }
    currentFrameIndex = constrain(currentFrameIndex, 0, min(totalFrames, MAX_FRAME) - 1);
  }
}

/**
 * This method is called when a program execution is 
 * suspended by the tool.
 */
void extraMode() {
  if(customKeyPressed) changeFrame();
  displayFrame(currentFrameIndex);
}

void displayFrame(int frameIndex) {
  if (frameIndex >= 0 && frameIndex < min(totalFrames, MAX_FRAME)) {
    PImage frameImage = savedShapes[frameIndex].frameImage;
    image(frameImage, 0, 0);
  }
}

boolean drawingMode = true;
int recodeFrameCount = 1;


void changeDrawingMode() {
  if (drawingMode) {

    drawingMode = false;
    recodeFrameCount = frameCount;
  } else {

    drawingMode = true;
    frameCount = recodeFrameCount;
  }
}

void drawEnd() {
  saveShapes();
  
  currentTransformation = new Transformation();
  lastTransformation = null;
  previousSavedTransformation = null;
  transformationsChanged = false;
}

boolean customMousePressed = false;
boolean previousMousePressed = false;

// pmouseX / pmouseY are variables that hold the mouse of the previous frame. 
// This tool enlarges the window (by widthAdd / heightAdd) to draw 
// its own UI (the record list on the right and the timeline at the bottom). 
// Without care, the user's sketch (drawMain) would react to mouse coordinates
// that are actually over the tool's UI.
void updateMouseState() {
  customMousePressed = mousePressed && !previousMousePressed;
  previousMousePressed = mousePressed;

  // Keep the raw position (which may be over the UI) for the tool's own
  // hit-testing via mouseOverAlt().
  mouseXAlt = mouseX;
  mouseYAlt = mouseY;

  if (!(mouseX <= width && mouseY <= height && mouseX >= 0 && mouseY >= 0)) {
    // Cursor is over the tool's UI: freeze the sketch's mouse position at the
    // previous frame's value (pmouseX / pmouseY) so drawMain is unaffected
    // instead of seeing coordinates that fall inside the UI area.
    mouseX = pmouseX;
    mouseY = pmouseY;
  }
}

boolean mouseOverAlt(float x, float y, float w, float h) {
  return mouseXAlt > x && mouseXAlt < x+w && mouseYAlt > y && mouseYAlt < y+h;
}

boolean customKeyPressed = false;
boolean previousKeyPressed = false;

void updateKeyState() {
  customKeyPressed = keyPressed && !previousKeyPressed;
  previousKeyPressed = keyPressed;
}

class SavedFrame {
  int frameCount;
  ArrayList<ShapeRecord> shapes = new ArrayList<ShapeRecord>();
  PImage frameImage;

  SavedFrame(int frameCount, PImage frameImage, ArrayList<ShapeRecord> shapes) {
    this.frameCount = frameCount;
    this.frameImage = frameImage;
    this.shapes = new ArrayList<ShapeRecord>(shapes);
  }
}

int MAX_FRAME = 1024;
SavedFrame[] savedShapes = new SavedFrame[MAX_FRAME];
int totalFrames = 0;

void saveShapes() {
  PImage frameImage = get();
  savedShapes[totalFrames % MAX_FRAME] = new SavedFrame(frameCount, frameImage, shapes);
  
  currentFrameIndex = totalFrames % MAX_FRAME;
  totalFrames++;
}

int widthAdd  = 280;
int heightAdd = 100;
int widthAlt, heightAlt;
int mouseXAlt = 0, mouseYAlt = 0;
float btnSize = 0;

/**
 * This method enables the tool.
 */
void extraSettings() {
  if (TOOL_DISABLED) {
    return;
  }
  
  width = widthAlt - widthAdd;
  height = heightAlt - heightAdd;
  
  int size = width * height;
  if (size > 160000) {
    MAX_FRAME = 160000 * MAX_FRAME / size;
    if (MAX_FRAME < 10) MAX_FRAME = 10;
  }
  
  btnSize = width / 8;
  if (btnSize > 30) btnSize = 30;
}


Transformation currentTransformation = new Transformation();
Transformation lastTransformation = null;
boolean transformationsChanged = false;
Transformation previousSavedTransformation = null;

class Transformation {
  float translateX = 0;
  float translateY = 0;
  float scaleX = 1;
  float scaleY = 1;
  float rotateAngle = 0;

  Transformation() {}

  Transformation(Transformation t) {
    this.translateX = t.translateX;
    this.translateY = t.translateY;
    this.scaleX = t.scaleX;
    this.scaleY = t.scaleY;
    this.rotateAngle = t.rotateAngle;
  }
  
  public boolean isIdentity() {
    return translateX == 0 && translateY == 0 &&
           scaleX == 1 && scaleY == 1 &&
           rotateAngle == 0;
  }
  
  @Override
  public boolean equals(Object obj) {
    if (this == obj) return true;
    if (obj == null || getClass() != obj.getClass()) {
      return false;
    }
    Transformation other = (Transformation) obj;
    return translateX == other.translateX && 
           translateY == other.translateY &&
           scaleX == other.scaleX && 
           scaleY == other.scaleY &&
           rotateAngle == other.rotateAngle;
  }
  
  void reset() {
    this.translateX = 0;
    this.translateY = 0;
    this.scaleX = 1;
    this.scaleY = 1;
    this.rotateAngle = 0;
  }
}

float scrollOffset = 0;


void drawUI() {
  pushMatrix();
  pushStyle();
  
  // Set color for drawing GUI
  colorMode(RGB, 255, 255, 255);
  stroke(0, 0, 0);
  strokeWeight(1);
  fill(255, 255, 255);
  rectMode(CORNER);

  // Draw a rect for the timeline pane
  super.rect(-5, height, widthAlt, heightAdd);

  if (mouseOverAlt(width/16*15-btnSize, height+heightAdd/16*3, btnSize, heightAdd/4)) {
    if (customMousePressed) {
      changeDrawingMode();
    }
  }
  
  fill(0);
  textSize(16);
  textAlign(RIGHT, CENTER);
  if (drawingMode) {
    super.text(frameCount, width/16*14-btnSize/2, height+heightAdd/16*5);
    fill(255);
  } else {
    super.text(savedShapes[currentFrameIndex].frameCount, width/16*14-btnSize/2, height+heightAdd/16*5);
    noStroke();
    fill(255, 0, 0);
  }
  textSize(13);

  super.rect(width/16*15-btnSize, height+heightAdd/16*3, btnSize, heightAdd/4);
  stroke(0);
  
  displayShapeRecords(width+5, 20);
  displayTimelineBar(width/16, height+heightAdd/8*5, width/8*7, heightAdd/4);
  
  popMatrix();
  popStyle();
}

String formatShapeParams(String type, Object[] params) {
  StringBuilder sb = new StringBuilder(type);
  sb.append("(");
  for (int i = 0; i < params.length; i++) {
    if (params[i] instanceof PImage) {
      sb.append("PImage");
    } else if (params[i] instanceof String) {
      sb.append("\"").append(params[i]).append("\"");
    } else {
      sb.append(params[i].toString());
    }
    if (i < params.length - 1) {
      sb.append(", ");
    }
  }
  sb.append(")");
  return sb.toString();
}

/**
 * Toggles the red highlight for the shape whose method name is drawn
 * with its baseline at lineY. Clicking the same name again clears it.
 */
void checkLabelClick(int i, float lineY) {
  if (customMousePressed && mouseOverAlt(width, lineY - 15, widthAdd - 20, 20)) {
    // Clear any previous highlight (e.g. from clicking a shape on the canvas)
    // so that only one function name is highlighted at a time.
    clickedIndices.clear();
    highlightedShapeIndex = (highlightedShapeIndex == i) ? -1 : i;
  }
}

void displayShapeRecords(float x, float y) {
  textAlign(LEFT);
  SavedFrame frame = savedShapes[currentFrameIndex];
  Transformation lastDisplayedTransformation = null;
  boolean inTransformationBlock = false;

  float displayAreaX = width;
  float displayAreaY = -1;
  float displayAreaWidth = widthAdd;
  float displayAreaHeight = heightAlt;
  
  fill(255);
  beginShape();
  vertex(displayAreaX, displayAreaY);
  vertex(displayAreaX + displayAreaWidth, displayAreaY);
  vertex(displayAreaX + displayAreaWidth, displayAreaY + displayAreaHeight);
  vertex(displayAreaX, displayAreaY + displayAreaHeight);
  endShape(CLOSE);
  
  float yPosition = y + scrollOffset;
  
  for (int i = 0; i < frame.shapes.size(); i++) {
    ShapeRecord shape = frame.shapes.get(i);
    String formattedShape = formatShapeParams(shape.type, shape.params);
    String methodAndShape = shape.methodName + ": " + formattedShape;

    int lastIndex = (clickedIndices.size() > 0) ? clickedIndices.get(clickedIndices.size() - 1) : -1;
    
    if (lastIndex == i || i == highlightedShapeIndex) {
      fill(255, 0, 0);
    } else {
      fill(0);
    }
    
    if (yPosition >= displayAreaY - 20 && yPosition <= displayAreaY + displayAreaHeight) {
      if (i == 0 && shape.type.equals("background")) {
        super.text(methodAndShape, x, yPosition);
        checkLabelClick(i, yPosition);
        yPosition += 20;
        lastDisplayedTransformation = null;
        inTransformationBlock = false;
        continue;
      }

      if (shape.transformation != null) {
        Transformation trans = shape.transformation;
        if (lastDisplayedTransformation == null || !trans.equals(lastDisplayedTransformation)) {
          if (inTransformationBlock) {
            yPosition += 3;
          }

          StringBuilder transInfo = new StringBuilder();
          if (trans.translateX != 0 || trans.translateY != 0) {
            transInfo.append(String.format("translate(%.2f, %.2f); ", trans.translateX, trans.translateY));
          }
          if (trans.scaleX != 1 || trans.scaleY != 1) {
            transInfo.append(String.format("scale(%.2f, %.2f); ", trans.scaleX, trans.scaleY));
          }
          if (trans.rotateAngle != 0) {
            transInfo.append(String.format("rotate(%.2f); ", trans.rotateAngle));
          }

          if (transInfo.length() > 0) {
            super.text(transInfo.toString(), x, yPosition);
            yPosition += 20;
          }

          lastDisplayedTransformation = trans;
          inTransformationBlock = true;
        }
        super.text("  | " + methodAndShape, x, yPosition);
        checkLabelClick(i, yPosition);
      } else {
        if (inTransformationBlock) {
          yPosition += 10;
        }
        super.text(methodAndShape, x, yPosition);
        checkLabelClick(i, yPosition);
        inTransformationBlock = false;
        lastDisplayedTransformation = null;
      }
    }
    yPosition += 20;
  }
  
  float buttonWidth = 20;
  float buttonHeight = 20;
  float buttonX = width + widthAdd - buttonWidth;
  float upButtonY = 0;
  float downButtonY = heightAlt - buttonHeight;
  fill(200);
  super.rect(buttonX, upButtonY, buttonWidth, buttonHeight);
  fill(0);
  super.triangle(
    buttonX + buttonWidth / 2, upButtonY + 5,
    buttonX + 5, upButtonY + buttonHeight - 5,
    buttonX + buttonWidth - 5, upButtonY + buttonHeight - 5
  );
  fill(200);
  super.rect(buttonX, downButtonY, buttonWidth, buttonHeight);
  fill(0);
  super.triangle(
    buttonX + 5, downButtonY + 5,
    buttonX + buttonWidth - 5, downButtonY + 5,
    buttonX + buttonWidth / 2, downButtonY + buttonHeight - 5
  );
  float contentHeight = yPosition - y -scrollOffset + 10;
  if (contentHeight > heightAlt) {
    float scrollBarHeight = downButtonY - upButtonY - buttonHeight * 2;
    float barHeight = map(displayAreaHeight, 0, contentHeight, 0, scrollBarHeight);
    barHeight = constrain(barHeight, buttonHeight, scrollBarHeight);
    float barY = map(-scrollOffset, 0, contentHeight - displayAreaHeight, upButtonY + buttonHeight, downButtonY - barHeight);
    fill(150);
    super.rect(buttonX + buttonWidth/4, barY, buttonWidth / 2, barHeight);
    
    
    if (mouseOverAlt(buttonX, barY, buttonWidth, barHeight / 2)) {
      if (customMousePressed) {

      }
      if (mousePressed) {
        scrollOffset += 20;
      }
    } else if (mouseOverAlt(buttonX, barY + barHeight / 2, buttonWidth, barHeight / 2)) {
      if (customMousePressed) {

      }
      if (mousePressed) {
        scrollOffset -= 20;
      }
    }
    if (customMousePressed) {
      if (mouseOverAlt(buttonX, upButtonY, buttonWidth, buttonHeight)) {

        scrollOffset += 20;
      } else if (mouseOverAlt(buttonX, downButtonY, buttonWidth, buttonHeight)) {

        scrollOffset -= 20;
      }
    }
  }
  

  float maxScrollOffset = min(0, displayAreaHeight - contentHeight);
  scrollOffset = constrain(scrollOffset, maxScrollOffset, 0);

  fill(255);
}


void displayTimelineBar(float x, float y, float w, float h) {
  noStroke();
  for (int i = 0; i < MAX_FRAME; i++) {
    if (i < totalFrames) {
      fill(255, 232, 183);
      if (!drawingMode) {
        if (mousePressed) {
          if (mouseOverAlt(x+i*w/MAX_FRAME, y, w/MAX_FRAME, h)) {
            if (customMousePressed) {

            }
            currentFrameIndex = min(totalFrames, i);
            highlightedShapeIndex = -1;
          }
        }
      }
    } else fill(120);
    super.rect(x+i*w/MAX_FRAME, y, w/MAX_FRAME, h);
  }

  fill(0, 0, 255);
  rectMode(CENTER);
  super.rect(x+(currentFrameIndex+1/2)*w/MAX_FRAME, y+h/2, 4, h);
  if (!drawingMode) {
    fill(255, 0, 0);
  } else {
    fill(0, 0, 255);
  }
  super.rect(x+((totalFrames-1)%MAX_FRAME+1/2)*w/MAX_FRAME, y+h/2, 5, h);
  rectMode(CORNER);
}
