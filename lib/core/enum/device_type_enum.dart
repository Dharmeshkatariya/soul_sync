
enum DeviceTypeEnum {
  mobile(1),
  tablet(2),
  smallWeb(3),
  mediumWeb(4),
  largeWeb(5);

  final int webSizeType;

  const DeviceTypeEnum(this.webSizeType);

  bool operator >(DeviceTypeEnum other) => webSizeType > other.webSizeType;

  bool operator >=(DeviceTypeEnum other) => webSizeType >= other.webSizeType;

  bool operator <(DeviceTypeEnum other) => webSizeType < other.webSizeType;

  bool operator <=(DeviceTypeEnum other) => webSizeType <= other.webSizeType;
}