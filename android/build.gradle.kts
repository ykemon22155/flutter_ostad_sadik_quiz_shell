allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// এই অংশটুকু পরিবর্তন করে বসিয়ে দিন
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("kotlin-build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}