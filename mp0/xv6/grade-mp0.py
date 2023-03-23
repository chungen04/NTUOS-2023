from gradelib import *

r = Runner()


@test(5, "mp0 command with public testcase 0")
def test_mp0_0():
    r.run_qemu(shell_script([
        'testgen',
        'mp0 os2202 a',
    ]))
    r.match(
        'os2202 [error opening dir]',
        '',
        '0 directories, 0 files',
    )


@test(5, "mp0 command with public testcase 1")
def test_mp0_1():
    r.run_qemu(shell_script([
        # 'testgen',
        'mp0 os2202/ o',
    ]))
    r.match(
        'os2202/ [error opening dir]',
        '',
        '0 directories, 0 files',
    )


@test(5, "mp0 command with public testcase 2")
def test_mp0_2():
    r.run_qemu(shell_script([
        # 'testgen',
        'mp0 os2023 o',
    ]))
    r.match(
        'os2023 1',
        'os2023/d1 1',
        'os2023/d2 1',
        'os2023/d2/a 1',
        'os2023/d2/b 1',
        'os2023/d2/c 1',
        'os2023/d3 1',
        'os2023/d3/a 1',
        'os2023/d3/b 1',
        '',
        '6 directories, 2 files',
    )


@test(5, "mp0 command with public testcase 3")
def test_mp0_3():
    r.run_qemu(shell_script([
        # 'testgen',
        'mp0 os2023/ o',
    ]))
    r.match(
        'os2023/ 1',
        'os2023//d1 1',
        'os2023//d2 1',
        'os2023//d2/a 1',
        'os2023//d2/b 1',
        'os2023//d2/c 1',
        'os2023//d3 1',
        'os2023//d3/a 1',
        'os2023//d3/b 1',
        '',
        '6 directories, 2 files',
    )


@test(10, "mp0 command with public testcase 4")
def test_mp0_4():
    r.run_qemu(shell_script([
        # 'testgen',
        'mp0 a a',
    ]))
    r.match(
        'a 1',
        'a/0 1',
        'a/1 1',
        'a/2 1',
        'a/3 1',
        'a/4 1',
        'a/5 1',
        'a/6 1',
        'a/7 1',
        'a/8 1',
        'a/9 1',
        'a/10 1',
        '',
        '11 directories, 0 files',
    )


@test(10, "mp0 command with public testcase 5")
def test_mp0_5():
    r.run_qemu(shell_script([
        # 'testgen',
        'mp0 a/ a',
    ]))
    r.match(
        'a/ 1',
        'a//0 1',
        'a//1 1',
        'a//2 1',
        'a//3 1',
        'a//4 1',
        'a//5 1',
        'a//6 1',
        'a//7 1',
        'a//8 1',
        'a//9 1',
        'a//10 1',
        '',
        '11 directories, 0 files',
    )


@test(10, "mp0 command with private testcase 0")
def test_tree_private_0():
    r.run_qemu(shell_script(['mp0 count z']))
    r.match(
        'count [error opening dir]',
        '',
        '0 directories, 0 files',
    )


@test(25, "mp0 command with private testcase 1")
def test_tree_private_1():
    r.run_qemu(shell_script(['mp0 sdnjk2nj18 a']))
    r.match(
        "sdnjk2nj18 0",
        "sdnjk2nj18/aaaaaaaa01 8",
        "sdnjk2nj18/aaaaaaaa01/aaaaaaaa02 16",
        "sdnjk2nj18/aaaaaaaa01/aaaaaaaa02/aaaaaaaa03 24",
        "sdnjk2nj18/aaaaaaaa01/aaaaaaaa02/aaaaaaaa03/aaaaaaaa04 32",
        "sdnjk2nj18/aaaaaaaa01/aaaaaaaa02/aaaaaaaa03/zzzzzzzz00 24",
        "sdnjk2nj18/aaaaaaaa01/aaaaaaaa02/aaaaaaaa03/zzzzzzzz01 24",
        "sdnjk2nj18/aaaaaaaa01/aaaaaaaa02/aaaaaaaa03/zzzzzzzz02 24",
        "sdnjk2nj18/aaaaaaaa01/aaaaaaaa02/aaaaaaaa03/zzzzzzzz03 24",
        "sdnjk2nj18/aaaaaaaa01/aaaaaaaa02/aaaaaaaa03/zzzzzzzz04 24",
        "sdnjk2nj18/aaaaaaaa01/aaaaaaaa02/aaaaaaaa03/zzzzzzzz05 24",
        "sdnjk2nj18/aaaaaaaa01/aaaaaaaa02/aaaaaaaa03/zzzzzzzz06 24",
        "sdnjk2nj18/aaaaaaaa01/aaaaaaaa02/aaaaaaaa03/zzzzzzzz07 24",
        "sdnjk2nj18/aaaaaaaa01/aaaaaaaa02/aaaaaaaa03/zzzzzzzz08 24",
        "sdnjk2nj18/aaaaaaaa01/aaaaaaaa02/aaaaaaaa03/zzzzzzzz09 24",
        "sdnjk2nj18/aaaaaaaa01/aaaaaaaa02/aaaaaaaa03/zzzzzzzz11 24",
        "sdnjk2nj18/aaaaaaaa01/aaaaaaaa02/aaaaaaaa03/zzzzzzzz12 24",
        "sdnjk2nj18/aaaaaaaa01/aaaaaaaa02/aaaaaaaa03/zzzzzzzz13 24",
        "sdnjk2nj18/aaaaaaaa01/aaaaaaaa02/aaaaaaaa03/zzzzzzzz14 24",
        "sdnjk2nj18/aaaaaaaa01/aaaaaaaa02/aaaaaaaa03/zzzzzzzz15 24",
        "sdnjk2nj18/aaaaaaaa01/aaaaaaaa02/aaaaaaaa03/zzzzzzzz16 24",
        "",
        "4 directories, 16 files",
    )


@test(25, "mp0 command with private testcase 2")
def test_tree_private_2():
    r.run_qemu(shell_script([
        # 'testgen',
        'mp0 b24dd5eac6 c',
    ]))
    r.match(
        "b24dd5eac6 1",
        "b24dd5eac6/cd938f3100 2",
        "b24dd5eac6/cc938f3101 3",
        "b24dd5eac6/ccc38f3102 4",
        "b24dd5eac6/cccc8f3103 5",
        "b24dd5eac6/cccccf3104 6",
        "b24dd5eac6/cccccc3105 7",
        "b24dd5eac6/ccccccc106 8",
        "b24dd5eac6/cccccccc07 9",
        "b24dd5eac6/bd938f3108 1",
        "b24dd5eac6/bd938f3109 1",
        "b24dd5eac6/bd938f3110 1",
        "b24dd5eac6/bd938f3111 1",
        "b24dd5eac6/bd938f3112 1",
        "b24dd5eac6/bd938f3113 1",
        "b24dd5eac6/bd938f3114 1",
        "b24dd5eac6/bd938f3115 1",
        "b24dd5eac6/bd938f3116 1",
        "b24dd5eac6/bd938f3117 1",
        "b24dd5eac6/bd938f3118 1",
        "b24dd5eac6/bd938f3119 1",
        "",
        "20 directories, 0 files",
    )


run_tests()
