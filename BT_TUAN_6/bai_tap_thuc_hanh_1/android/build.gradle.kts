allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Cấu hình đường dẫn thư mục build ra ngoài root của Flutter (../../build)
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    // Sửa lỗi Type mismatch và Deprecated: Dùng layout.buildDirectory thay vì buildDir
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}