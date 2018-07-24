import SceneKit

// Create the scene
let sceneSize = SCNVector3(600, 600, 200)
let scene = SCNScene()

// Create a spline with randomly placed points
let spline = Spline(
    points: {
        () -> [SCNVector3] in
        // Generate random points
        var points = [SCNVector3]()
        let pointCount = 30
        for _ in 0..<pointCount {
            points += [
                SCNVector3(
                    CGFloat(arc4random()) / CGFloat(UINT32_MAX) * sceneSize.x - sceneSize.x / 2,
                    CGFloat(arc4random()) / CGFloat(UINT32_MAX) * sceneSize.y - sceneSize.y / 2,
                    CGFloat(arc4random()) / CGFloat(UINT32_MAX) * sceneSize.z - sceneSize.z / 2
                )
            ]
        }
        return points
    }(),
    method: .Cubic
)

// Adds spheres along the spline; this is done in an external source file to make the process instant
generateScene(scene: scene, sceneSize: sceneSize, spline: spline, nodeCount: 1000)

scene
