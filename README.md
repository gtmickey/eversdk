本项目用于打包rust tonclient 的API， 为android so库 和 ios xcframework

rust api修改目录 rust/src/api
只要 目录中的代码有改变，修改后必须执行 `flutter_rust_bridge_codegen generate`
用户重新生成代码和签名（签名和打包产物二进制中的记录的值一一对应）

代码修改并重新生成完成后， 需要将
rust/src/api/* 中的所有文件
以及以下三个生成的文件
rust/src/frb_generated.io.rs
rust/src/frb_generated.rs
rust/src/frb_generated.web.rs

覆盖 https://github.com/gtmickey/ton_client_sdk.git lib目录下同名文件

1. 打包 android so: `flutter build apk --release` 结束后， 会在build/rust_lib_eversdk/jniLibs/release
   目录下产生不同平台二进制库
   将对应 so 替换 https://github.com/gtmickey/ton_client_sdk.git 中
   android/src/main/jniLibs中的对应架构的so即可

2. 打包ios xcframework:
   如果当前目录有缓存的 rust_lib_eversdk.xcframework 文件夹， 先删除该文件夹，避免导出缓存
   - 打包真机库：连上真机 `flutter run --release` 直接运行, 或 `flutter build ios --release` 等待运行成功，在build/ios/Release-iphoneos/rust_lib_eversdk
   下会产生一个 .framework库，暂存
   - 打包虚拟机库：连上虚拟机 `flutter run`,
   等待运行成功，在build/ios/Debug-iphonesimulator/rust_lib_eversdk 下会产生一个 .framework库，暂存
   当ios两种设备.framework 库打包完成后，
   执行 export_xcframework.sh 脚本， 该脚本会自动去build/ios/目录将以上架构 .framework 合并为
   rust_lib_eversdk.xcframework 并导出到当前目录。
   将 rust_lib_eversdk.xcframework 拷贝至  https://github.com/gtmickey/ton_client_sdk.git
   ios/Frameworks/中替换旧库即可





