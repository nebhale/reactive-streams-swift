import PackageDescription

let package = Package(
    name: "ReactiveStreams",
    targets: [
        Target(name: "ReactiveStreamsExamples", dependencies: [.Target(name: "ReactiveStreams")])
    ]
)
