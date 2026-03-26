allprojects {
    repositories {
        google()
        mavenCentral()
        // maven {
            // url = uri("https://jitpack.io")
        // }
        // maven {
        //     url = uri("https://repository.paymob.com/repository/maven-releases/")
        // }
        // maven {
        //     url = rootProject.projectDir.toURI().resolve("libs")
        // }
    }
    // configurations.all {
    //     resolutionStrategy.force("com.paymob.sdk:Paymob-SDK:1.8.0")
    // }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
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
