//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Fri, May 11, 2012  3:04:55 PM
// Author: tomyeh
part of rikulo_html;

/**
 * A collection of CSS utilities
 */
class CSS {
  /** The prefix used for non-standard CSS property.
   * For example, it is `-webkit-` for a Webkit-based browser.
   * If you're not sure whether to prefix a CSS property, please use
   * [name] instead.
   */
  static final String prefix = browser.webkit ? "-webkit-":
    browser.msie ? "-ms-": browser.firefox ? "-moz-": browser.opera ? "-o-": "";

  ///A list of the property names of CSS text related styles.
  static const List<String> textNames = const [
    'font-family', 'font-size', 'font-weight', 'font-style',
    'letter-spacing', 'line-height', 'text-align', 'text-decoration',
    'text-indent', 'text-shadow', 'text-transform', 'text-overflow',
    'direction', 'word-spacing', 'white-space'];

  /** Converts a CSS value representing a pixel.
   * In other words, it converts a number to a string appended with "px".
   * Notice that it returns an empty string if [val] is null.
   */
  static String px(num val) {
    return val != null ? "${val}px": "";
  }
  /** Converts a CSS value representing a color.
   */
  static String color(int red, int green, int blue, [num alpha]) {
    return alpha != null ? "rgba($red,$green,$blue,$alpha)":
      "#${StringUtil.toHexString(red,2)}${StringUtil.toHexString(green,2)}${StringUtil.toHexString(blue,2)}";
  }

  /** Converts a [Transformation] object to CSS value for property transform.
   */
  static String transform(Transformation t) => 
      "matrix(${t[0][0]}, ${t[1][0]}, ${t[0][1]}, ${t[1][1]}, ${t[0][2]}, ${t[1][2]})";
  /** Converts a CSS value presenting `translate3d` for the property called `transform`.
   */
  static String translate3d(int x, int y, [int z])
  => "translate3d(${x}px,${y}px,${z != null ? z: 0}px)";
  /** Converts a string of a 3-tuples to [Offset3d].
   * If it is 2-tuples, [Offset3d.z] will be zero.
   */
  static Offset3d offset3dOf(String value) {
    if (value == null || value.isEmpty)
      return new Offset3d(0, 0, 0);

    final List<int> ary = [0, 0, 0];
    int i = value.indexOf('(');
    if (i >= 0) value = value.substring(i + 1);
    i = 0;
    for (String tuple in value.split(',')) {
      ary[i++] = intOf(tuple);
      if (i == 3)
        break;
    }
    return new Offset3d(ary[0], ary[1], ary[2]);
  }
  /** Converts a string of a CSS value to an integer.
   * It returns 0 if value is null, empty, or failed to parse.
	 *
	 * By default, it returns `defaultValue` (default: 0)
   * if it failed to parse the given value.
	 * If you prefer to throw an exception, specify [reportError] to true.
   */
  static int intOf(String value, {int defaultValue: 0, bool reportError}) {
    try {
      if (value != null && !value.isEmpty) {
        final Match m = _reNum.firstMatch(value);
        if (m != null)
          return int.parse(m.group(0));
      }
    } catch (e) {
      if (reportError != null && reportError)
        throw e;
    }
    return defaultValue;
  }
  static final RegExp _reNum = new RegExp(r"([-]?[0-9]+)");
  
  /** Return the sum of the integers of the given [values] converted by [intOf]
   * function. 
   */
  static int sumOf(List<String> values, {bool reportError}) {
    int sum = 0;
    for (String v in values)
      sum += intOf(v, reportError: reportError);
    return sum;
  }

  ///Copy the properties of the given names from one declaration, src, to another, dest.
  static void copy(CSSStyleDeclaration dest, CSSStyleDeclaration src, List<String> names) {
    for (int j = names.length; --j >= 0;) {
      final String nm = names[j];
      final String val = src.getPropertyValue(nm);
      dest.setProperty(nm, val != null ? val: "");
    }
  }

  /** Returns the corrected name for the given CSS property name.
   * For example, `css('text-size-adjust')` will return
   * `'-webkit-text-size-adjust'` if the browser is Webkit-based.
   *
   * Notice that the prefix is defined in [prefix].
   */
  static String name(String propertyName) {
    if (_nsnms == null) {
      _nsnms = new Set.from(const [
        'animation', 'animation-delay', 'animation-direction',
        'animation-duration', 'animation-fill-mode',
        'animation-iteration-count', 'animation-name',
        'animation-play-state', 'animation-timing-function',
        'appearance', 'backface-visibility',
        'background-composite',
        'border-after', 'border-after-color',
        'border-after-style', 'border-after-width',
        'border-before', 'border-before-color',
        'border-before-style', 'border-before-width',
        'border-end', 'border-end-color', 'border-end-style',
        'border-end-width', 'border-fit',
        'border-horizontal-spacing',
        'border-start', 'border-start-color',
        'border-start-style', 'border-start-width',
        'border-vertical-spacing',
        'box-align', 'box-direction', 'box-flex',
        'box-flex-group', 'box-lines', 'box-ordinal-group',
        'box-orient', 'box-pack', 'box-reflect',
        'color-correction', 'column-break-after',
        'column-break-before', 'column-break-inside',
        'column-count', 'column-gap', 'column-rule',
        'column-rule-color', 'column-rule-style',
        'column-rule-width', 'column-span', 'column-width',
        'columns', 'filter',
        'flex-align', 'flex-flow', 'flex-order',
        'flex-pack',
        'flow-from', 'flow-into',
        'font-feature-settings', 'font-size-delta',
        'font-smoothing',
        'highlight', 'hyphenate-character',
        'hyphenate-limit-after', 'hyphenate-limit-before',
        'hyphenate-limit-lines', 'hyphens',
        'line-box-contain', 'line-break', 'line-clamp',
        'locale', 'logical-height', 'logical-width',
        'margin-after', 'margin-after-collapse',
        'margin-before', 'margin-before-collapse',
        'margin-bottom-collapse', 'margin-collapse',
        'margin-end', 'margin-start', 'margin-top-collapse',
        'marquee', 'marquee-direction', 'marquee-increment',
        'marquee-repetition', 'marquee-speed', 'marquee-style',
        'mask', 'mask-attachment', 'mask-box-image',
        'mask-box-image-outset', 'mask-box-image-repeat',
        'mask-box-image-slice', 'mask-box-image-source',
        'mask-box-image-width', 'mask-clip', 'mask-composite',
        'mask-image', 'mask-origin', 'mask-position',
        'mask-position-x', 'mask-position-y', 'mask-repeat',
        'mask-repeat-x', 'mask-repeat-y', 'mask-size',
        'match-nearest-mail-blockquote-color',
        'max-logical-height', 'max-logical-width',
        'min-logical-height', 'min-logical-width',
        'nbsp-mode',
        'padding-after', 'padding-before', 'padding-end',
        'padding-start',
        'perspective', 'perspective-origin',
        'perspective-origin-x', 'perspective-origin-y',
        'region-break-after', 'region-break-before',
        'region-break-inside', 'region-overflow',
        'rtl-ordering', 'tap-highlight-color',
        'text-combine', 'text-decorations-in-effect',
        'text-emphasis', 'text-emphasis-color',
        'text-emphasis-position', 'text-emphasis-style',
        'text-fill-color', 'text-orientation',
        'text-security', 'text-size-adjust',
        'text-stroke', 'text-stroke-color', 'text-stroke-width',
        'transform', 'transform-origin', 'transform-origin-x',
        'transform-origin-y', 'transform-origin-z',
        'transform-style',
        'transition', 'transition-delay', 'transition-duration',
        'transition-property', 'transition-timing-function',
        'user-drag', 'user-modify', 'user-select',
        'wrap-shape', 'writing-mode']);

      //TODO: check other attributes for non-standard properties (like we did for box-sizing)
      //CONSIDER: auto-generate this file with a tool
      if ((browser.ios && browser.iosVersion < 5)
      || (browser.android && browser.androidVersion < 2.4)
      || browser.firefox)
        _nsnms.add('box-sizing');
    }
    return _nsnms.contains(propertyName) ? "$prefix$propertyName": propertyName;
  }
  static Set<String> _nsnms; //non-standard CSS property names
}
