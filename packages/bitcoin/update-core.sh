echo 'fetching stackmate-core'
git clone https://github.com/i5hi/stackmate-core.git

echo 'building stackmate-core for android'
echo 'this might take a while ..'
cd stackmate-core
make android

echo 'updating to new jni binaries'
mv -f ./target/aarch64-linux-android/release/libstackmate.so ../android/src/main/jniLibs/arm64-v8a
mv -f ./target/armv7-linux-androideabi/release/libstackmate.so ../android/src/main/jniLibs/armeabi-v7a
mv -f ./target/i686-linux-android/release/libstackmate.so ../android/src/main/jniLibs/x86
mv -f ./target/x86_64-linux-android/release/libstackmate.so ../android/src/main/jniLibs/x86_64

echo 'cleaning up ..'
cd ..
rm -f -r stackmate-core

echo 'stackmate-core updated !'
