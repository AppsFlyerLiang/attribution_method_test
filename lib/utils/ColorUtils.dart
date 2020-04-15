import 'dart:ui';

class ColorUtils {
  static Color light(Color accentColor) {
    int red = accentColor.red + 128;
    int green = accentColor.green + 128;
    int blue = accentColor.blue + 128;
    return accentColor.withRed(red > 255 ? 255 : red).withBlue(blue > 255 ? 255 : blue).withGreen(green > 255 ? 255 : green);
  }
  static Color dark(Color accentColor) {
    int red = accentColor.red - 128;
    int green = accentColor.green - 128;
    int blue = accentColor.blue - 128;
    return accentColor.withRed(red < 0 ? 0 : red).withBlue(blue < 0 ? 0 : blue).withGreen(green < 0 ? 0 : green);
  }

}