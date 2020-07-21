from setuptools import setup, Extension, find_packages
from setuptools.command.build_ext import build_ext

# with open("README.md", "r") as fh:
#     long_description = fh.read()


# inject numpy headers
class build_ext_robsel(build_ext):
    def finalize_options(self):
        build_ext.finalize_options(self)
        # Prevent numpy from thinking it is still in its setup process:
        # `__builtins__` can be a dict
        # see https://docs.python.org/2/reference/executionmodel.html
        if isinstance(__builtins__, dict):
            __builtins__['__NUMPY_SETUP__'] = False
        else:
            __builtins__.__NUMPY_SETUP__ = False

        import numpy
        self.include_dirs.append(numpy.get_include())

setup(
    name="robust-selection",
    version="0.0.7",
    author="Chau Tran",
    author_email="chautran@ucsb.edu",
    cmdclass={'build_ext': build_ext_robsel},
    description="Distributionally Robust Formulation and Model Selection for the Graphical Lasso",
    # long_description=long_description,
    # long_description_content_type="text/markdown",
    url="https://github.com/dddlab/robust-selection",
    packages=['robsel'],
    package_dir={'robsel':'robsel'},
    python_requires='>=3.6',
    install_requires=["numpy >= 1.15",
                      "scikit-learn >= 0.22.1"],
    setup_requires=["numpy >= 1.15",
                    "scikit-learn >= 0.22.1"],
)

