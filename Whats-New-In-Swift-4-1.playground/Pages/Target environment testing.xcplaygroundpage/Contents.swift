/*:
 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)

 ## Target environment testing

 Swift 4.1 implements [SE-0190](https://github.com/apple/swift-evolution/blob/master/proposals/0190-target-environment-platform-condition.md), which introduces a new `targetEnvironment` condition that lets us differentiate between builds that are for physical devices and those that are for a simulated environment.

 At this time `targetEnvironment` has only one value, `simulator`, which will be true if your build is targeting a simulated device such as the iOS Simulator.

 For example:
 */
#if targetEnvironment(simulator)
   // code for the simulator here
#else
   // code for real devices here
#endif
/*:
 This is useful when writing code to deal with functionality the simulator doesn't support, such as capturing photos from a camera or reading the accelerometer.

 As an example, let's look at processing a photo from the camera. If we're running on a real device we'll create and configure a `UIImagePickerController()` to take photos using the camera, but if we're in the simulator we'll just load a sample image from our app bundle:
 */
import UIKit

class TestViewController: UIViewController, UIImagePickerControllerDelegate {
   // a method that does some sort of image processing
   func processPhoto(_ img: UIImage) {
       // process photo here
   }

   // a method that loads a photo either using the camera or using a sample
   func takePhoto() {
      #if targetEnvironment(simulator)
         // we're building for the simulator; use the sample photo
         if let img = UIImage(named: "sample") {
            processPhoto(img)
         } else {
            fatalError("Sample image failed to load")
         }
      #else
         // we're building for a real device; take an actual photo
         let picker = UIImagePickerController()
         picker.sourceType = .camera
         vc.allowsEditing = true
         picker.delegate = self
         present(picker, animated: true)
      #endif
   }

   // this is called if the photo was taken successfully
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
      // hide the camera
      picker.dismiss(animated: true)

      // attempt to retrieve the photo they took
      guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else {
         // that failed; bail out
         return
      }

      // we have an image, so we can process it
      processPhoto(image)
   }
}
/*:
 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)
 */
