class MouseDto {
  final double x;
  final double y;
  final bool left;
  final bool right;
  final bool scrollUp;
  final bool scrollDown;

  MouseDto({
    required this.x,
    required this.y,
    required this.left,
    required this.right,
    required this.scrollUp,
    required this.scrollDown,
  });

  factory MouseDto.fromJson(Map<String, dynamic> json) {
    return MouseDto(
      x: json['x'],
      y: json['y'],
      left: json['left'],
      right: json['right'],
      scrollUp: json['scrollUp'],
      scrollDown: json['scrollDown'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "x": x,
      "y": y,
      "left": left,
      "right": right,
      "scrollUp": scrollUp,
      "scrollDown": scrollDown,
    };
  }
}
