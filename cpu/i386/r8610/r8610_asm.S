/*
 * (C) Copyright 2002
 * Daniel Engstr�m, Omicron Ceti AB <daniel@omicron.se>.
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
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
 * MA 02111-1307 USA
 */

.globl mem_init
mem_init:
/* This function should return the available memory count in %eax */

/* TODO, verify RAM performance / stability */
/*
 *Configure the RAM.
 * These setting originated from the RDC document :
 * "R8610 Hardware setting guide v13", and are modified where needed
 */


	movw	$0xcf8, %dx
	movl	$0x80003848, %eax
	outl	%eax,%dx

/*1. SDRAM PHASE */
	/* Setting SDRAM PHASE */
	movw	$0xcf8, %dx
	movl	$0x80003848, %eax
	outl	%eax, %dx

	movw	$0xCFC, %dx
	movl	$0x0006C99F, %eax
	outl	%eax, %dx

/*2. SDRAM Delay Line and Bank control It depends on what kind of SDRAM you used */
	/*SDRAM 32M case (NANYA NT5SV16M16BS-75B * 1) */
	/* Setting DelayLine value */
	movw	$0xCF8, %dx
	movl	$0x80000064, %eax
	outl	%eax, %dx

	movw	$0xCFC, %dx
	inl		%dx, %eax

	andl	$0xFF00FFFF, %eax
	orl		$0x00790000, %eax
	outl	%eax, %dx

  /*Setting Memory bank register */
	movw	$0xCF8, %dx
	movl	$0x8000006C, %eax
	outl	%eax, %dx
	movw	$0xCFC, %dx
	movl	$0x00000451, %eax
	outl	%eax, %dx

/*3. Enable Timer2 for SDRAM refresh */
	/*Init DRAM refresh */
	movw	$0x043, %dx
	movb	$0x54, %al
	outw 	%ax, %dx

	movw	$0x041, %dx
	movb	$0x12, %al
	outb	%al, %dx

	/* Hardcode that we've got 32 Mib of ram at address 0x4000000. This could be cleaner, but lets get it up
	 * and running first, than worry about thist stuff */

	movl $0x500000, %eax

	jmp	*%ebp
