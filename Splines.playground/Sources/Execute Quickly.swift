import SceneKit

public func generateScene(scene: SCNScene, sceneSize: SCNVector3, spline: Spline, nodeCount: Int) {
    // Add a camera
    let cameraNode = SCNNode()
    cameraNode.camera = SCNCamera()
    let cameraDistance = 600 as CGFloat // Distance the camera is from where the boxes will be
    cameraNode.position.z = cameraDistance // Position the camera
    let conversionFactor: Double = 180 / M_PI // Conversion factor from rad to deg
    cameraNode.camera?.xFov = atan2(Double(sceneSize.x / 2), Double(cameraDistance)) * 2 * conversionFactor // Do a little trig to make sure the camera sees the whole scene
    cameraNode.camera?.yFov = atan2(Double(sceneSize.y / 2), Double(cameraDistance)) * 2 * conversionFactor
    scene.rootNode.addChildNode(cameraNode)
    
    // Add spheres along the spline
    let sphere = SCNSphere(radius: 5)
    sphere.firstMaterial?.emission.contents = NSColor.redColor()
    sphere.firstMaterial?.diffuse.contents = NSColor.blackColor()
    for i in 0..<nodeCount {
        let sphereNode = SCNNode(geometry: sphere)
        let time = CGFloat(i) / CGFloat(nodeCount - 1)
        sphereNode.position = spline.evalutate(time: time)
        sphereNode.eulerAngles = spline.evaluateRotation(time: time, axis: .All)
        scene.rootNode.addChildNode(sphereNode)
    }
}