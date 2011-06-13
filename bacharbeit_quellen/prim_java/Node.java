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

public class Node {
	private int xPos, yPos, no, key, parent, index, nodes[], edges[];
	private Color c;
	private boolean active;

	/*********************************
	 * Constructor of the Node class *
	 *********************************/
	public Node(int x, int y, int number) {
		xPos = x;
		yPos = y;
		no = number;
		c = new Color(102,153,255);
		active = false;
		index = 0;
		nodes = new int[8];
		edges = new int[8];
	}
	
	/**************************************************************************
	 * addPath method adds edges and nodes to adjacent arrays in sorted order *
	 **************************************************************************/
	public void addPath(int nodeNum, int edgeNum) {
		int temp;
		nodes[index] = nodeNum;
		edges[index] = edgeNum;
		for (int i=index;i > 0;i--) {
			if (nodes[i] < nodes[i-1]) {
				temp = nodes[i];
				nodes[i] = nodes[i-1];
				nodes[i-1] = temp;
				temp = edges[i];
				edges[i] = edges[i-1];
				edges[i-1] = temp;
			}
		}
		index++;
	}
	
	/*************************************************************************
	 * isAdj method checks if the given node number is adjacent to this node *
	 * returns true on succes and false on failure					 *
	 *************************************************************************/
	public boolean isAdj(int num) {
		for (int i=0;i < index;i++) {
			if (num == nodes[i])
				return true;
		}
		return false;
	}
	
	/*************************************************************************
	 * isAdj method checks if the given node number is parent of this node *
	 * returns true on succes and false on failure					 *
	 *************************************************************************/
	public boolean isParent(int p) {
		if (parent == p)
			return true;
		else 
			return false;
	}
	
	public void setKey(int weight) { key = weight; } // set key of the node to given weight
	public void setParent(int p) { parent = p; } // set parent of the node to given node number
	public void setActive() { active = true; } // set node active
	public void setColor(Color color) { c = color; } // set node color
	public void setPosition(int x, int y) { // set node position 
		xPos = x;
		yPos = y;
	}
	
	public int xPos() { return xPos; } // return the x position of the node
	public int yPos() { return yPos; } // return the y position of the node
	public int no() { return no; } // return the node number
	public Color color() { return c; } // return the node color
	public int Key() { return key; } // return the key of the node
	public int Parent() { return parent; } // return the parent of the node
	public boolean isActive() { return active; } // check if the node is active
	public int lastIndex() { return index; } // return the index number of adjacent nodes array
	public int getNodeNum(int i) { return nodes[i]; } // return the node number which is adjacent to this node
	public int getEdgeNum(int i) {return edges[i]; } // return the edge number which is adjacent to this node 
} 