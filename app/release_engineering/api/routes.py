

from flask import Blueprint,jsonify


from app.release_engineering.version.manager import VersionManager

from app.release_engineering.build.info import BuildInformation

from app.release_engineering.manifest.registry import ReleaseManifest

from app.release_engineering.package.builder import ReleaseBuilder



release_api=Blueprint(

"release_engineering",

__name__,

url_prefix="/api/release"

)



version=VersionManager()

build=BuildInformation()

manifest=ReleaseManifest()

package=ReleaseBuilder()



@release_api.route("/version")
def version_info():


    return jsonify(

    version.info()

    )





@release_api.route("/build")
def build_info():


    return jsonify(

    build.generate()

    )





@release_api.route("/manifest")
def release_manifest():


    return jsonify(

    manifest.generate()

    )





@release_api.route("/package")
def create_package():


    return jsonify(

    package.package()

    )



