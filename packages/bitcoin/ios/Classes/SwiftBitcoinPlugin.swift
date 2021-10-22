import Flutter
import UIKit

public class SwiftBitcoinPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    // let channel = FlutterMethodChannel(name: "bitcoin", binaryMessenger: registrar.messenger())
    // let instance = SwiftBitcoinPlugin()
    // registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }

   public func dummyMethodToEnforceBundling() {
    // This will never be executed
    // print("\n\n---- xyz ------");

    generate_master("12","","")
    import_master("","","");
    derive_hardened("","","");
    compile("","");
    sync_balance("","");
    get_address("","","");
    sync_history("","");
    get_fees("","","");
    build_tx("","","","","");
    sign_tx("","","");
    broadcast_tx("","","");
    cstring_free("");

  }
}
