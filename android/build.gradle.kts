allprojects {
    repositories {
        mavenLocal()
        google()
        mavenCentral()

        // Mintegral
        maven {
            url = uri("https://dl-maven-android.mintegral.com/repository/mbridge_android_sdk_oversea")
            content { includeGroupByRegex("com.mbridge.*") }
        }

        // ChartBoost ads
        maven {
            url = uri("https://cboost.jfrog.io/artifactory/chartboost-mediation")
            content { includeGroup("com.chartboost") }
        }
        maven {
            url = uri("https://cboost.jfrog.io/artifactory/chartboost-ads")
            content { includeGroup("com.chartboost") }
        }
        maven {
            url = uri("https://cboost.jfrog.io/artifactory/chartboost-core")
            content { includeGroup("com.chartboost") }
        }

        // Wortise ads
        maven {
            url = uri("https://maven.wortise.com/artifactory/public")
            content { includeGroupByRegex("com.wortise.*") }
        }
    }
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
