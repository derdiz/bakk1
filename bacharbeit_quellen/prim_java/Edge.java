/*
 * Copyright (C) 2001 Mustafa Incel
 * 
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
 */

package com.mincel.prim;

import java.awt.Color;

public class Edge {
	private Node first, second;
	private int w;
	private Color c;

	/*****************************
	 * constructor of Edge class *
	 *****************************/
	public Edge(Node firstNode, Node secondNode, int weight, Color color) {
		first = firstNode;
		second = secondNode;
		w = weight;
		c = color;
	}
		
	public void setWeight(int weight) { w = weight; } // set edge weight to given weight
	public void setColor(Color color) { c = color; } // set edge color to given color
	
	public Node firstNode() { return first; } // return the first node which is in this edge
	public Node secondNode() { return second; } // return the second node which is in this edge
	public int weight() { return w; } // return the edge weight
	public Color color() { return c; } // return the edge color
	
	public int xPos() {
		double hyp, x, y;
		x = second.xPos() - first.xPos();
		y = second.yPos() - first.yPos();
		hyp = Math.sqrt(x*x + y*y);
		return (first.xPos() + (int)((x/hyp)*(hyp/2)));
	}

	public int yPos() {		
		double hyp, x, y;
		x = second.xPos() - first.xPos();
		y = second.yPos() - first.yPos();
		hyp = Math.sqrt(x*x + y*y);
		return (first.yPos() + (int)((y/hyp)*(hyp/2)));
	}
}
