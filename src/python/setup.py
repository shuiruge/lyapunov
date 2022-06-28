from setuptools import setup, find_packages


NAME = 'lyapunov'
AUTHOR = 'shuiruge'
AUTHOR_EMAIL = 'shuiruge@whu.edu.cn'
URL = 'https://github.com/shuiruge/lyapunov'
VERSION = '0.0.1'


setup(
    name=NAME,
    version=VERSION,
    author=AUTHOR,
    author_email=AUTHOR_EMAIL,
    url=URL,
    packages=find_packages(exclude=[
        'tests.*', 'tests',
        'examples.*', 'examples',
        'dat.*', 'dat']),
    classifiers=[
        'Programming Language :: Python :: 3+',
    ],
    zip_safe=False,
)
