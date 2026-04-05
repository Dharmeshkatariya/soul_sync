enum ToastDuration {
  short(3),
  medium((6)),
  long(12),
  sticky(3600);
  final int seconds;
  const ToastDuration(this.seconds);
}