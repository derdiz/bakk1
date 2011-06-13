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
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
 */

package com.mincel.prim;

import java.awt.Canvas;
import java.awt.Color;
import java.awt.Graphics;
import java.awt.TextField;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;

public class GraphCanvas extends Canvas implements MouseListener {
	private final static int MAX_WEIGHT = 99;
	private final static Color yellow = new Color(255,255,204);
	private final static Color blue = new Color(102,153,255);
	private final static Color black = new Color(0,0,0);
	private final static Color red = new Color(255,0,0);
	private boolean clicked, selected, located;
	private int mx, my, xPos, yPos, ni, ei, n1, n2, e1, e2, status;
	public Node nodes[];
	public Edge edges[];
	public TextField text;

	/* Constructor of drawingCanvas */
	public GraphCanvas(int maxx, int maxy) {
		mx = maxx;
		my = maxy;
		setSize(mx, my);
		clicked = false; selected = false;
		status=0; ni=0; ei=0;
		nodes = new Node[9]; //create a Node array of size 9
		edges = new Edge[36]; //create an Edge array of size 36
		text = new TextField(2); //create a text field
      	addMouseListener(this); // add mouse listener to this object 
	}

	/*******************************************************************
	 * paint method draws graphics on the screen and called implicitly *
	 *******************************************************************/
	public void paint(Graphics g) {
		for (int i=0;i < ei;i++) {
			Edge e = edges[i];
			/* draw an edge */
			drawEdge(e.firstNode(), e.secondNode(), e.weight(), e.color(), g);
		}
		for (int i=0;i < ni;i++) {
			Node n = nodes[i];
			/* draw a node */
			drawNode(n.xPos()-8, n.yPos()-8, n.no()+1, n.color(), g);
		}
	}
	
	/***************************************************************************
	 * update method erases any drawing that was previously done on the applet *
	 * then invokes the paint method and passes it the Graphics object for you *
	 ***************************************************************************/
	public void update(Graphics g) {
		if (located) { // if new node located
			g.clearRect(0, 0, mx, my); // clear the screen
			located = false; // set located false
		}
		paint(g); // call paint
	}

	/********************************************************************
	 * locate method creates a node an place it in a circular structure *
	 ********************************************************************/
	public void locate() {
        int x=140, y=125, xPos, yPos;
		double angle;

		if (ni < 9) { // if node index smaller than 9
			nodes[ni] = new Node(0, 0, ni); // create a new node
			ni++; // increase node index
		}
		angle = 360/ni; // angle is equal to 360 over number of nodes
		for (int i=0; i < ni; i++) { // for all nodes
			angle -= 360/ni;
			xPos = x + (int)(100*Math.cos((angle+90)/180*Math.PI));	// calculate x position
			yPos = y - (int)(100*Math.sin((angle+90)/180*Math.PI));	// calculate y position
			nodes[i].setPosition(xPos, yPos); // set node position
		}
		located = true; // set located true
		repaint(); // call repaint
	}

	/**************************************************************************
	* drawNode method draws a node at the given coordinates and in given the *
	* color                                                                  *
	**************************************************************************/
	private void drawNode(int x, int y, int no, Color c, Graphics g) {
		g.setColor(c); // set current color to the given color
		g.fillOval(x, y, 17, 17); // draw an oval which is filled with the current color
		g.setColor(black); // set current color to black
		g.drawOval(x, y, 16, 16); // draw an oval
		g.drawString(Integer.toString(no), x+5, y+13); // draw the node number
	}
	
	/***************************************************************************
	* drawEdge method draws an edge between the given points and in the given *
	* color                                                                   *
	***************************************************************************/
	private void drawEdge(Node first, Node second, int weight, Color c, Graphics g) {
		double hyp, x, y;
		int x1 = first.xPos();
		int y1 = first.yPos();
		int x2 = second.xPos();
		int y2 = second.yPos();
		x = x2 - x1;
		y = y2 - y1;
		hyp = Math.sqrt(x*x + y*y); // calculate the distance between the given two point
		g.setColor(c); // set current color to the given color
		g.drawLine(x1, y1, x2, y2); // draw a line between the given points
		x1 = x1 + (int)((x/hyp)*(hyp/2)); // calculate the middle of the given two points
		y1 = y1 + (int)((y/hyp)*(hyp/2));    
		g.setColor(yellow); // set current color to yellow
		g.fillOval(x1-8, y1-8, 17, 17);
		g.setColor(c); // set current color to the given color
		if (weight < 10)
			g.drawString(Integer.toString(weight), x1-3, y1+5); // draw the edge weight
		else
			g.drawString(Integer.toString(weight), x1-6, y1+5); // draw the edge weight
	}
	
	/*******************************************************************
	 * changeEdgeWeight method changes the weight of the selected edge *
	 *******************************************************************/
	public void changeEdgeWeight() {
		int weight;
		if (selected) { // if selected flag is set
			weight = Integer.parseInt(text.getText());
			text.setText(""); // empty text item
			if (weight > MAX_WEIGHT) // is given weight bigger than MAX_WEIGHT
				weight = MAX_WEIGHT; // set weight MAX_WEIGHT
			edges[e1].setColor(black); // set edge color to black
			edges[e1].setWeight(weight); // set edge weight to the given weight 
			selected = false; // set selected flag to false
			repaint(); // call repaint
		}
	}

	/**********************************************************************
	 * isNode method checks if there is a node at the given x, y position *
	 * and returns the node index on succes -1 on failure                 *
	 **********************************************************************/
	private int isNode(int x, int y) {
		for (int i=0;i < ni;i++) {
			if (Math.abs(nodes[i].xPos()-x) < 9 && Math.abs(nodes[i].yPos()-y) < 9)
				return i; // return node index
		}
		return -1; // return -1
	}
		
	/**********************************************************************
	 * isCloseToNode method checks if there is a node near the given x, y *
	 * position and returns the node index on succes -1 on failure        *
	 **********************************************************************/
	private int isCloseToNode(int x, int y) {
		for (int i=0;i < ni;i++) {
			if (Math.abs(nodes[i].xPos()-x) < 36 && Math.abs(nodes[i].yPos()-y) < 36)
				return i; // return node index
		}
		return -1; // return -1
	}

	/***********************************************************************
	 * isEdge method checks if there is an edge at the given x, y position *
	 * and returns the edge index on succes -1 on failure                  *
	 ***********************************************************************/
	private int isEdge(int x, int y) {
		for (int i=0;i < ei;i++) {
			if (Math.abs(edges[i].xPos()-x) < 9 && Math.abs(edges[i].yPos()-y) < 9)
				return i; // return edge index
		}
		return -1; // return -1
	}
	
	/* set status */
	public void setStatus(int s) { status = s; }  
	
	/**************************************************************
	 * numOfNodes method return the number of nodes on the screen *
	 **************************************************************/
	public int numOfNodes() { return ni; }

	/*************************************************************************
	 * method mousePressed is called when a mouse button is pressed with the *
	 * mouse cursor on a component                                           *
	 *************************************************************************/
	public void mousePressed(MouseEvent e) {
		if (status == 0) {
			xPos = e.getX(); // get x position of mouse curser
			yPos = e.getY(); // get y position of mouse curser
			if (isCloseToNode(xPos, yPos) == -1 && ni < 9) { // if other nodes are not too close
				nodes[ni] = new Node(xPos, yPos, ni); // create a new node
				ni++; // increase the node index
				repaint(); // call repaint
			}
		} else if (status == 1) {
			if (!clicked) {
				n1 = isNode(e.getX(), e.getY()); // check if there is a node at x, y
				if (n1 != -1) { // if there is a node at x, y
					nodes[n1].setColor(red); // change the node color to red 
					clicked = true; // set clicked true
					repaint(); // call repaint
				}
			} else {
				n2 = isNode(e.getX(), e.getY()); // check if there is a node at x, y
				if (n2 != -1) { // if there is a node at x, y
					/* if first and second nodes are the same */
					if (nodes[n1].no() == nodes[n2].no()) {
						nodes[n1].setColor(blue); // change the node color to blue
						clicked = false; // set clicked true
						repaint(); // call repaint
					} else if (!nodes[n1].isAdj(nodes[n2].no())) { /* if first and second nodes are not the same check if it is adjacent */
						int weight;
						if (text.getText().equals("")) { // if weight is not given
							weight = (int)(Math.random()*MAX_WEIGHT); // create a randon weight
							while (weight == 0) // while wight equals to 0
								weight = (int)(Math.random()*MAX_WEIGHT); // create a new randon weight
						} else {												// if weight is given
							weight = Integer.parseInt(text.getText()); // set weight
							text.setText(""); // empty text field
							if (weight > MAX_WEIGHT) // if weight bigger than MAX_WEIGHT
								weight = MAX_WEIGHT; // set weight MAX_WEIGHT
						}
						/* create a new edge from first node to second node */
						edges[ei] = new Edge(nodes[n1], nodes[n2], weight, black);
						nodes[n1].addPath(nodes[n2].no(),ei); // update first node's path
						nodes[n2].addPath(nodes[n1].no(),ei); // update second node's path
						nodes[n1].setColor(blue); // set first node's color to blue 
						clicked = false; // set clicked false
						ei++; // increase edge index
						repaint(); // call repaint
					}
				}
			}
		} else if (status == 2) {
			if (!selected) {
				e1 = isEdge(e.getX(), e.getY()); // check if there is an edge at x, y
				if ( e1 != -1) { // if there is an edge at x, y
					edges[e1].setColor(red); // set edge color to red
					text.setText(Integer.toString(edges[e1].weight())); // set text field to edge weight				
					selected = true; // set selected true
					repaint(); // call repaint
				}
			} else {
				e2 = isEdge(e.getX(), e.getY()); // check if there is an edge at x, y
				if ( e2 != -1 && e1 == e2) { // if there is an edge at x, y and two edges are the same
					edges[e2].setColor(black); // ser edge color to black
					text.setText(""); // empty test field
					selected = false; // ser selected flase
					repaint(); // call repaint
				}
			}
		}
	}

	public void mouseReleased(MouseEvent e) {}
	public void mouseDragged(MouseEvent e) {}
	public void mouseMoved(MouseEvent e) {}
	public void mouseEntered(MouseEvent e) {}
	public void mouseExited(MouseEvent e) {}
	public void mouseClicked(MouseEvent e) {}
}
