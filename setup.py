from setuptools import setup, Extension, find_packages
from setuptools.command.build_ext import build_ext

with open("README.md", "r") as fh:
    long_description = fh.read()


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
    version="0.0.1",
    author="Example Author",
    author_email="author@example.com",
    cmdclass={'build_ext': build_ext_cvxpy},
    description="A small example package",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/cbtran/robust_selection",
    packages=find_packages(),
    python_requires='>=3.6',
    install_requires=["numpy >= 1.15",
                      "scipy >= 1.1.0"],
    setup_requires=["numpy >= 1.15"],
)

