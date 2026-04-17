#include <dirent.h>
#include <fcntl.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>


// Macros
#define ALIGN_UP(val, alignment)                                               \
  ((((val) + (alignment)-1) / (alignment)) * (alignment))

#define ALIGN_DOWN(val, alignment) ((val) - ((val) % (alignment)))

#define MAGIC_HEADER_OFFSET   16
#define IFS_ALIGNMENT         4096


/*
 *
 */
int main(int argc, char *argv[])
{
  uint8_t *buf;
  int output_fd;
  int bootloader_fd;
  int ifs_fd;
  size_t ifs_offset;
  size_t ifs_size;
  size_t output_size;
  uint32_t *magic_header;
  struct stat bootloader_stat;
  struct stat ifs_stat;
  
  if (argc != 4) {
    printf("Usage: mkifs output_file bootloader_file ifs_file\n");
    return -1;
  }

  printf("output     : %s\n", argv[1]);
  printf("bootloader : %s\n", argv[2]);
  printf("ifs        : %s\n", argv[3]);

  output_fd = open(argv[1], O_RDWR | O_TRUNC | O_CREAT, S_IRUSR | S_IWUSR);

  if (output_fd < 0) {
    return EXIT_FAILURE;
  }

  bootloader_fd = open(argv[2], O_RDONLY);

  if (bootloader_fd < 0) {
    return EXIT_FAILURE;
  }

  ifs_fd = open(argv[3], O_RDONLY);

  if (ifs_fd < 0) {
    return EXIT_FAILURE;
  }

  fstat(bootloader_fd, &bootloader_stat);
  fstat(ifs_fd, &ifs_stat);

  ifs_offset = ALIGN_UP(bootloader_stat.st_size, IFS_ALIGNMENT);
  ifs_size = ALIGN_UP(ifs_stat.st_size, IFS_ALIGNMENT);
  output_size = ifs_offset + ifs_size;
  
  if ((buf = malloc(output_size)) == NULL) {
    return EXIT_FAILURE;
  }
  
  if (read(bootloader_fd, buf, bootloader_stat.st_size) != bootloader_stat.st_size) {
    return EXIT_FAILURE;
  }
  
  if (read(ifs_fd, buf + ifs_offset, ifs_stat.st_size) != ifs_stat.st_size) {
    return EXIT_FAILURE;
  }

  // Update bootloader magic header

  magic_header = (uint32_t *)(buf + MAGIC_HEADER_OFFSET); 

  magic_header[0] = ifs_offset;
  magic_header[1] = ifs_size;

  // Write out combined bootloader and IFS image
  
  if (write(output_fd, buf, output_size) != output_size) {
    return EXIT_FAILURE;
  }

  free(buf);  
  close(ifs_fd);
  close(bootloader_fd);
  close(output_fd);
  
  return 0;
}



