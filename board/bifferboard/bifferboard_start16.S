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
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
 * MA 02111-1307 USA
 */

/*
 * 16bit initialization code.
 * This code have to map the area of the boot flash
 * that is used by U-boot to its final destination.
 */

.text
.section .start16, "ax"
.code16
.globl board_init16
board_init16:


	/* turn on the RED led to let the world know, were alive */
	movw	$0xcf8, %dx
	movl	$0x80003848, %eax
	outl	%eax,%dx

	movw	$0xcfc, %dx
	movl	$0x00010000, %eax
	outl	%eax,%dx

	movw	$0xcf8, %dx
	movl	$0x8000384c, %eax
	outl	%eax,%dx

	movw	$0xcfc, %dx
	movl	$0x00000000, %eax
	outl	%eax,%dx


	/*
	 * Internal UART Control Register: Register Offset: 53h
	 *
	 * 7 UIADE R/W Enable/Disable Internal UART IO Address Decode : 1
	 * 6-4 Rsvd RO Reserved
	 * Bit 3 Bit 2 Bit 1 Bit 0 Routing Table : 0 1 0 0 IRQ[4]
	 *
	 * setting: 10000100 : 0x84
	 *
	 * */

	/* configure and turn on address translation of the serial port */
	movw	$0xcf8, %dx
	movl	$0x80003854, %eax
	outl	%eax,%dx

	movw	$0xcfc, %dx
	movl	$0x000003f8, %eax
	outl	%eax,%dx

	movw	$0xcf8, %dx
	movl	$0x80003850, %eax
	outl	%eax,%dx

	movw	$0xcfc, %dx
	movl	$0x84801012, %eax
	outl	%eax,%dx

	/* the return address is stored in bp */
	jmp	*%bp

.section .bios, "ax"
.code16
.globl realmode_reset
.hidden realmode_reset
.type realmode_reset, @function
realmode_reset:
	/* Alias MMCR to 0xdf000 */
	movw	$0xfffc, %dx
	movl	$0x800df0cb, %eax
	outl	%eax, %dx

	/* Set ds to point to MMCR alias */
	movw	$0xdf00, %ax
	movw	%ax, %ds

	/* issue software reset thorugh MMCR */
	movl    $0xd72, %edi
	movb	$0x01, %al
	movb	%al, (%di)

	jmp *TEXT_BASE

/*1:	hlt
	jmp	1*/
