#include "kernel/types.h"
#include "kernel/stat.h"
#include "kernel/fs.h"
#include "user/user.h"
#include "kernel/param.h"
#include "kernel/fcntl.h"
#include "kernel/syscall.h"
#include "kernel/memlayout.h"
#include "kernel/riscv.h"


char* fmtname(char *path) {
    static char buf[DIRSIZ+1];
    char *p;

    // Find first character after last slash.
    for(p=path+strlen(path); p >= path && *p != '/'; p--)
        ;
    p++;

    // Return blank-padded name.
    if(strlen(p) >= DIRSIZ)
        return p;
    memmove(buf, p, strlen(p));
    memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
    return buf;
}

int calc_occ(char *path, char* key){
    // only key[0] is the key
    int occ = 0;
    for(int i=0; i<strlen(path); i++){
        if(path[i] == key[0]){
            occ++;
        }
    }
    return occ;
}

void traverse(char *path, char *key, int* dir_count, int* file_count){
    char buf[80], *p;
    int fd;
    struct dirent de;
    struct stat st;

    if((fd = open(path, 0)) < 0){
        fprintf(2, "%s [error opening dir]\n", path);
        return;
    }

    if(fstat(fd, &st) < 0){
        fprintf(2, "ls: cannot stat %s\n", path);
        close(fd);
        return;
    }
    int occ = calc_occ(path, key);
    switch(st.type){
    case T_FILE:;
        printf("%s %d\n", path, occ);
        *file_count += 1;
        break;

    case T_DIR:;
        occ = calc_occ(path, key);
        printf("%s %d\n", path, occ);
        if(strlen(path) + 1 + DIRSIZ + 1 > sizeof(buf)){
            printf("ls: path too long\n");
            break;
        }
        *dir_count += 1;
        strcpy(buf, path);
        p = buf+strlen(buf);
        *p++ = '/';
        while(read(fd, &de, sizeof(de)) == sizeof(de)){
            // de: dir entry
            if(de.inum == 0) continue;
            if(!strcmp(de.name, ".")) continue;
            if(!strcmp(de.name, "..")) continue;
            memmove(p, de.name, DIRSIZ); // get name in inode and memmove to p 
            p[DIRSIZ] = 0;
            if(stat(buf, &st) < 0){
                printf("ls: cannot stat %s\n", buf);
                continue;
            }
            // printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
            if(st.type == T_DIR){
                traverse(buf, key, dir_count, file_count);
            }else if(st.type == T_FILE){
                *file_count += 1;
                occ = calc_occ(buf, key);
                printf("%s %d\n", buf, occ);
            }
        }
        break;
    }
    close(fd);
}

int main(int argc, char* argv[]){
    char* root_dir = argv[1];
    char* key = argv[2];

    int fd[2];
    pipe(fd);

    int pid = fork();

    if(pid == 0){
        close(fd[0]);
        int dir_count = 0;
        int file_count = 0;
        traverse(root_dir, key, &dir_count, &file_count);
        dir_count -= 1; // root dir
        write(fd[1], &dir_count, sizeof(int));
        write(fd[1], &file_count, sizeof(int));
        close(fd[1]);
        exit(0);
    }else{
        close(fd[1]);
        wait(&pid);
        int dir_count = 0;
        int file_count = 0;
        read(fd[0], &dir_count, sizeof(int));
        read(fd[0], &file_count, sizeof(int));
        if(dir_count > -1){
            printf("\n%d directories, %d files\n", dir_count, file_count);
        }else{
            printf("\n0 directories, 0 files\n");
        }
        close(fd[0]);
    }
    exit(0); // no process wrapper so should use exit
}