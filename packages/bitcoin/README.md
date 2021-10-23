TARGETS

arm64-v8a
ln -s /Users/mj/desktop/target/aarch64-linux-android/release/libditto.so .

armeabi-v7a
ln -s /Users/mj/desktop/target/armv7-linux-androideabi/release/libditto.so .

x86
ln -s /Users/mj/desktop/target/i686-linux-android/release/libditto.so .

x86_64
ln -s /Users/mj/desktop/target/x86_64-linux-android/release/libditto.so .


src
└── main
    └── jniLibs
        ├── arm64-v8a
        │   └── libexample.so@ -> ../../../../../rust/target/aarch64-linux-android/release/libexample.so
        ├── armeabi-v7a
        │   └── libexample.so@ -> ../../../../../rust/target/armv7-linux-androideabi/release/libexample.so
        ├── x86
        │   └── libexample.so@ -> ../../../../../rust/target/i686-linux-android/release/libexample.so
        └── x86_64
            └── libexample.so@ -> ../../../../../rust/target/x86_64-linux-android/release/libexample.so