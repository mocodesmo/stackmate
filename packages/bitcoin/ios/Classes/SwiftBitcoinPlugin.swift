import Flutter
import UIKit

public class SwiftBitcoinPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "bitcoin", binaryMessenger: registrar.messenger())
    let instance = SwiftBitcoinPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }

   public func dummyMethodToEnforceBundling() {
    // This will never be executed
    generate_master("","","");
    import_master("","","");
    derive_hardened("","","");
    compile("","");
    sync_balance("","");
    get_address("","","");
  }
}
