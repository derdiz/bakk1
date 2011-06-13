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

import java.awt.Canvas;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;

public class Prim extends Canvas {
	private final static int MAX_WEIGHT = 99;
	private int line[], ti=0, li, length;
	private boolean ended=true;
	private Node tree[];
	private GraphCanvas gc;
	private String algo[] = {"Q "+(char)8592+" V[G]",
	                         "for each u "+(char)1028+" Q",
	                         "  do key[u] "+(char)8592+" "+(char)8734,
	                         "key[r] "+(char)8592+" 0",
	                         (char)960+"[r] "+(char)8592+" NIL",
	                         "while (Q "+(char)8800+" "+(char)216+")",
	                         "  do u "+(char)8592+" Extract-Min(Q)",
	                         "    for each v "+(char)1028+" Adj[u]",
	                         "      do if v "+(char)1028+" Q and w(u,v) < key[u]",
	                         "        then "+(char)960+"[v] "+(char)8592+" u",
	                         "             key[v] "+(char)8592+" w(u,v)"};
	
	/*****************************
	 * constructor of Prim class *
	 *****************************/
	public Prim(GraphCanvas c) {
		gc = c;
		line = new int[64];
		tree = new Node[9];
	}

	/*******************************************************************
	 * paint method draws graphics on the screen and called implicitly *
	 *******************************************************************/
	public void paint(Graphics g) {
		int y=15;
		g.setFont(new Font("Monospaced", Font.PLAIN, 12));
		for (int i=0;i < algo.length;i++) {
			if (line[li] == i)
				g.setColor(Color.red);
			else
				g.setColor(Color.black);
			g.drawString(algo[i],10,y);
			y+=15;
		}
		if (li > 0) {
			if (line[li-1] == 6 && line[li] == 7) 
				gc.repaint();
			if (li == length) 
				ended = true;
		}
	}

	/***************************************************************************
	 * update method erases any drawing that was previously done on the applet *
	 * then invokes the paint method and passes it the Graphics object for you *
	 ***************************************************************************/
	public void update(Graphics g) {
		paint(g);
	}

	/*********************************************************************
	 * Step method performs the step simulation when we call this method *
	 *********************************************************************/
	public void Step() {
		/* if ended flag is set and tree index smaller than the number of nodes */
		if (ended && ti < gc.numOfNodes()) {
			primStep(); // call primStep method 
			repaint(); // call repaint
			ended = false; // set ended false
		} else {
			repaint(); // call repaint
			if (li < length) { li++; } // if line index smaller than length increase line index 
			else {
				line[0] = 0; // set line[0] to zero
				length = 0; // set length to zero
				li = 0; // set line index to zero
			}
		}
    }
    
	/***************************************************************************
	 * primSolve method find the minimum spanning tree of given directed graph *
	 * uses the Prim's Algorithm  to find the shortest path                    *
	 ***************************************************************************/
	public void primSolve() {
		int ni=0, numOfNodes=0; ti = 0;
		numOfNodes = gc.numOfNodes();
		for (int i=1; i < numOfNodes;i++)
			gc.nodes[i].setKey(MAX_WEIGHT); // set node key to MAX_WEIGHT
		gc.nodes[0].setKey(0); // set key of the root to 0
		gc.nodes[0].setParent(0); // set parent of the root to 0
		while (ti < numOfNodes) {
			if (ti == 0) {
				tree[ti] = gc.nodes[0];
				tree[ti].setColor(Color.red);
				tree[ti].setActive();
			} else {
				ni = extractMin();
				tree[ti] = gc.nodes[ni];
				tree[ti].setColor(Color.red);
				tree[ti].setActive();
			}
			for (int j=0;j < tree[ti].lastIndex();j++) {
				Edge e = gc.edges[tree[ti].getEdgeNum(j)];
				Node n = gc.nodes[tree[ti].getNodeNum(j)];
				if (!n.isActive() && e.weight() < n.Key()) { 
					n.setKey(e.weight());
					n.setParent(ni);
				}
			}
			ti++;
		}
		gc.repaint();
	}
	
	/***************************************************************************
	 * primSolve method find the minimum spanning tree of given directed graph *
	 * uses the Prim's Algorithm  to find the shortest path. Differently from  *
	 * the primSolve we have to call this methos for each node                 *
	 ***************************************************************************/
	private void primStep() {
		int ni=0; 
		li = 0;
		if (ti == 0) {
			for (int i=1; i < gc.numOfNodes();i++) {
				setLine(1); // set line 1
				gc.nodes[i].setKey(MAX_WEIGHT); // set node key to MAX_WEIGHT
				setLine(2); // set line 2
			}
			setLine(1); // set line 1
			gc.nodes[0].setKey(0); // set key of the root to 0
			setLine(3); // set line 3
			gc.nodes[0].setParent(0); // set parent of the root to 0
			setLine(4); // set line 4
		}
		setLine(5); // set line 5
		if (ti == 0) {
			tree[ti] = gc.nodes[0];
			tree[ti].setColor(Color.red);
			tree[ti].setActive();
			setLine(6); // set line 6
		} else {
			ni = extractMin();
			tree[ti] = gc.nodes[ni];
			tree[ti].setColor(Color.red);
			tree[ti].setActive();
			setLine(6);  // set line 6
		}
		for (int j=0;j < tree[ti].lastIndex();j++) {
			setLine(7); // set line 7
			Edge e = gc.edges[tree[ti].getEdgeNum(j)];
			Node n = gc.nodes[tree[ti].getNodeNum(j)];
			setLine(8); // set line 8
			if (!n.isActive() && e.weight() < n.Key()) { 
				setLine(9); // set line 9
				n.setKey(e.weight());
				setLine(10); // set line 10
				n.setParent(ni);
			}
		}
   		setLine(7); // set line 7
		ti++;
		li = 0;
	}
 
	/***************************************************************************
	 * extractMin finds the node which has the smallest key setand returns the *
	 * node number                                                             *
	 ***************************************************************************/
	private int extractMin() {
		int min=99, ni=0, ei=0;
		for (int i=0;i < ti;i++) {
			for (int j=0;j < tree[i].lastIndex();j++) {
				int nn = tree[i].getNodeNum(j);
				int en = tree[i].getEdgeNum(j);
				Node n = gc.nodes[nn]; 
				if (!n.isActive() && n.Key() < min && n.isParent(tree[i].no())) {
					min = gc.nodes[nn].Key();
					ni = nn;
					ei = en;
				}
			}
		}
		gc.edges[ei].setColor(Color.red);
		return ni;
	}

    /************************************************************************ 
     * set line method set the line number of the line array at given index *
     ************************************************************************/
	private void setLine(int l) {
		line[li] = l; 
		length = li;
		li++;
	}
}
