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

import java.applet.Applet;
import java.awt.BorderLayout;
import java.awt.Button;
import java.awt.Choice;
import java.awt.Color;
import java.awt.FlowLayout;
import java.awt.Label;
import java.awt.Panel;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;

public class Main extends Applet implements ActionListener, ItemListener {
	private int index;
	private boolean disabled = false;
	private GraphCanvas gc;
	private Prim prim;
	private Panel p1, p2, p3;
	private Choice choice;
	private Button locate, solve, step, enter;
	private Label label;

	public void init() {
		setBackground(new Color(102,153,255));

		gc = new GraphCanvas(280, 250);
		gc.setBackground(new Color(255,255,204));

		prim = new Prim(gc);
		prim.setBackground(Color.white);
		prim.setSize(275,250);

		choice = new Choice();
		choice.add("Add Node  ");
		choice.add("Add Edge  ");
		choice.add("Change    ");
		choice.addItemListener(this);

		locate = new Button(" Locate ");
		locate.addActionListener(this);

		solve = new Button(" Solve ");
		solve.addActionListener(this);

		step = new Button(" Step ");
		step.addActionListener(this);

		p1 = new Panel();
		p1.setLayout(new FlowLayout(FlowLayout.CENTER));
		p1.add(choice);
		p1.add(locate);
		p1.add(solve);
		p1.add(step);

		p2 = new Panel();
		p2.setLayout(new FlowLayout(FlowLayout.CENTER, 10, 0));
		p2.add(gc);
		p2.add(prim);
		
		label = new Label("Edge Weight:");
		gc.text.setBackground(Color.white);
		gc.text.addActionListener(this);

		enter = new Button(" Enter ");
		enter.addActionListener(this);

		p3 = new Panel();
		p3.setLayout(new FlowLayout(FlowLayout.CENTER));
		p3.add(label);
		p3.add(gc.text);
		p3.add(enter);

		setLayout(new BorderLayout());
		add(p1,BorderLayout.NORTH);
		add(p2,BorderLayout.CENTER);
		add(p3,BorderLayout.SOUTH);
	}
	
	private boolean isCompleted() {
		for (int i=0; i < gc.numOfNodes(); i++) {
			if (gc.nodes[i].lastIndex() == 0) {
				showStatus("You have to connect all the nodes");
				return false;
			}
		}
		return true;
	}

	public void itemStateChanged(ItemEvent e) {
		index = choice.getSelectedIndex();
		gc.setStatus(index);
	}

	public void actionPerformed (ActionEvent e) { 
		if (e.getSource() == locate && index == 0) {
			gc.locate();
			showStatus("Located");
		} else if (e.getSource() == solve) {
			if (isCompleted()) {
				if (!disabled) {
					choice.setEnabled(false);
					locate.setEnabled(false);
				}
				prim.primSolve();
				showStatus("Solved");
			}
		} else if (e.getSource() == step) {
			if (isCompleted()) {
				if (!disabled) {
					choice.setEnabled(false);
					locate.setEnabled(false);
				}
				prim.Step();
				showStatus("Step");
			}
		} else if (e.getSource() == enter || e.getSource() == gc.text) {
			gc.changeEdgeWeight();
		}
	}
					
}

