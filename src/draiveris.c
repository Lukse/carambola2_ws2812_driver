/*  
 *  hello-1.c - The simplest kernel module.
 */
#include <linux/init.h>
#include <linux/module.h>	/* Needed by all modules */
#include <linux/kernel.h>	/* Needed for KERN_INFO */
#include <linux/moduleparam.h>
#include <linux/stat.h>

//#include <linux/autoconf.h>
#include <linux/types.h>
//#include <linux/stddef.h>
#include <linux/string.h>
//#include <linux/i2c.h>
//#include <linux/i2c-algo-bit.h>
//#include <linux/fs.h>
//#include <asm/uaccess.h> /* for copy_from_user */

//#include <asm/mach-ath79/ar71xx_regs.h>
// cd /home/test/carambola2/build_dir/target-mips_r2_uClibc-0.9.33.2/linux-ar71xx_generic/linux-3.7.9/arch/mips/include/asm/mach-ath79/

#include <linux/sched.h>
#include <linux/spinlock.h>
#include <linux/watchdog.h>
#include <linux/ioctl.h>



#define sysRegRead(phys) \
 (*(volatile u32 *)KSEG1ADDR(phys)) 

#define sysRegWrite(phys, val) \
 ((*(volatile u32 *)KSEG1ADDR(phys)) = (val)) 


MODULE_LICENSE("GPL");
MODULE_AUTHOR("Saulius Lukse saulius.lukse@gmail.com");
MODULE_DESCRIPTION("test");


static char *mystring = "blah";
module_param(mystring, charp, 0000);
MODULE_PARM_DESC(mystring, "A character string");



void led_bit(int bit)
{
  if (bit==0)
  {
    // high (3.3us)
    sysRegWrite(0x1804000CL, 1<<20);
    sysRegWrite(0x1804000CL, 1<<20);
    sysRegWrite(0x1804000CL, 1<<20);
    sysRegWrite(0x1804000CL, 1<<20);
    sysRegWrite(0x1804000CL, 1<<20);

    // low (7us)
    sysRegWrite(0x18040010L, 1<<20);
    sysRegWrite(0x18040010L, 1<<20);
    sysRegWrite(0x18040010L, 1<<20);
    sysRegWrite(0x18040010L, 1<<20);
    sysRegWrite(0x18040010L, 1<<20);
    sysRegWrite(0x18040010L, 1<<20);
    sysRegWrite(0x18040010L, 1<<20);
    sysRegWrite(0x18040010L, 1<<20);
    sysRegWrite(0x18040010L, 1<<20);
    sysRegWrite(0x18040010L, 1<<20);
    sysRegWrite(0x18040010L, 1<<20);
    sysRegWrite(0x18040010L, 1<<20);
  }
  else
  {
    // high (3.3us)
    sysRegWrite(0x1804000CL, 1<<20);
    sysRegWrite(0x1804000CL, 1<<20);
    sysRegWrite(0x1804000CL, 1<<20);
    sysRegWrite(0x1804000CL, 1<<20);
    sysRegWrite(0x1804000CL, 1<<20);
    sysRegWrite(0x1804000CL, 1<<20);
    sysRegWrite(0x1804000CL, 1<<20);
    sysRegWrite(0x1804000CL, 1<<20);
    sysRegWrite(0x1804000CL, 1<<20);
    sysRegWrite(0x1804000CL, 1<<20);
    sysRegWrite(0x1804000CL, 1<<20);

    // low (7us)
    sysRegWrite(0x18040010L, 1<<20);
    sysRegWrite(0x18040010L, 1<<20);
    sysRegWrite(0x18040010L, 1<<20);
    sysRegWrite(0x18040010L, 1<<20);
    sysRegWrite(0x18040010L, 1<<20);
    sysRegWrite(0x18040010L, 1<<20);
    sysRegWrite(0x18040010L, 1<<20);
    sysRegWrite(0x18040010L, 1<<20);
    sysRegWrite(0x18040010L, 1<<20);
    sysRegWrite(0x18040010L, 1<<20);
  }

}




int init_module(void)
{
	printk(KERN_INFO "Hello world 1.\n");
	printk(KERN_INFO "mystring is a string: %s\n", mystring);
	printk(KERN_INFO "register: %04X\n", sysRegRead(0x18040004));



	//sysRegWrite(0x18040000L, 0xffffffff);

	//struct sched_param schedp;
    //schedp.sched_priority = 99;
    //sched_setscheduler(0, SCHED_RR, &schedp);

  //spin_lock_init();



  unsigned long flags;
  long int i = 0;


  sysRegWrite(0x1806000CL, 1<<31); // Just in case set watchdog to timeout some time later
  
  sysRegWrite(0x18040000L, 1<<20); // output enable to PIN20

  static DEFINE_SPINLOCK(critical);
  spin_lock_irqsave(&critical, flags);
  //for (i = 0; i<1000000; i++)
  for (i = 0; i<10; i++)
	{
    led_bit(1); led_bit(1); led_bit(1); led_bit(1); led_bit(1); led_bit(1); led_bit(1); led_bit(1);
    //led_bit(1); led_bit(1); led_bit(1); led_bit(1); led_bit(1); led_bit(1); led_bit(1); led_bit(1);
    led_bit(0); led_bit(0); led_bit(0); led_bit(0); led_bit(0); led_bit(0); led_bit(0); led_bit(0);    
    led_bit(0); led_bit(0); led_bit(0); led_bit(0); led_bit(0); led_bit(0); led_bit(0); led_bit(0);    
	}
  sysRegWrite(0x18040010L, 1<<20);
  spin_unlock_irqrestore(&critical, flags);

	
	return 0; //A non 0 return means init_module failed; module can't be loaded. 
}

void cleanup_module(void)
{
	printk(KERN_INFO "Goodbye world 1.\n");
}




