enum AssetEnum {
  appLogo("logo.png");

  const AssetEnum(String fileName) : path = "assets/$fileName";

  final String path;
}