/*
 * (C) Copyright 2008
 * Graeme Russ, graeme.russ@gmail.com.
 *
 * See file CREDITS for list of people who contributed to this
 * project.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
 * MA 02111-1307 USA
 */

#include <common.h>
#include <asm/io.h>


DECLARE_GLOBAL_DATA_PTR;

unsigned long monitor_flash_len = CONFIG_SYS_MONITOR_LEN;

/*
 * Miscellaneous platform dependent initializations
 */
int board_early_init_f(void)
{
	return 0;
}

int board_early_init_r(void)
{
	return 0;
}

int dram_init(void)
{
	return 0;
}

void show_boot_progress(int val)
{

}


int last_stage_init(void)
{
	int minor;
	int major;

	major = minor = 0;

	printf("%s %i : It's Alive\n", __FILE__, __LINE__ );

	return 0;
}

ulong board_flash_get_legacy (ulong base, int banknum, flash_info_t * info)
{
ulong 
	ret;
	
	ret = 0;
	
	return ret;
}
