
.extern Main

.global _start
.global rootfs_image_offset
.global rootfs_image_size

// Entry point into bootloader
// We have 2 variables that are overwritten by mkifs tool which stores the offset
// and size of the IFS Initial File System.
// The IFS image is copied to 64k, out of the way of the BSS section which we
// must clear.

.arm
.section .init

_start:
   b skip_magic
.balign 16

rootfs_image_offset:
    .long 0xdeadbeef
rootfs_image_size:
    .long 0xcafef00d

.balign 16

skip_magic:
  // Enable access to FP and NEON hardware by enabling access to CP10 and CP11.
  mov r1, #0xF << 20                // Enable CP10 and CP11
  mcr p15,0,r1,c1,c0,2              // CPACR
  isb
    
  // Switch on the FP and NEON hardware.
  mov r1, #0x1 << 30
  vmsr fpexc, r1

  // TODO: We may need to configure NSACR and HCPTR.
  //	  mrc p15, 0, r1, c1, c1, 2   // NSACR
  //    orr r1, #0x3 << 10          // Enable FP/SIMD	  
  //	  mcr p15, 0, r1, c1, c1, 2	  
  //    mov r1, #0x33FF    
  //    mcr p15,4,r1,c1,c1,2        // HCPTR

  mrs r0,cpsr
  bic r0,r0,#0x1F       // clear MODE_BITS
  orr r0,r0,#0x13       // set mode as SVC_MODE  (or sys_mode?)
  msr spsr_cxsf,r0

  add r0,pc,#4
  msr ELR_hyp,r0
  eret

  orr r0,r0,#0x1

  ldr sp, =root_stack_top
  b Main

.section .data
.balign 16
root_stack:
.skip 4096
root_stack_top:

