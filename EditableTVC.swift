//
//  EditableTVC.swift
//  EditableTableViewController-Swift
//
//  Created by Diego on 12/25/14.
//  Copyright (c) 2014 Diego.
//

import UIKit

class EditableTVC: UITableViewController {
	
	var myItems:NSMutableArray = NSMutableArray()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationItem.rightBarButtonItem = self.editButtonItem()
		for i in 0 ... 4
		{
			myItems.addObject(String(format: "Hey %d", i))
		}
	}
	
	// MARK: - Table view data source
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if(self.editing)
		{
			return myItems.count + 1
		}
		else
		{
			return myItems.count
		}
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("EditableCellPrototype", forIndexPath: indexPath) as UITableViewCell
		
		// Configure the cell...
		
		if(self.editing && indexPath.row == myItems.count)
		{
			cell.textLabel?.text = "Add ..."
		}
		else
		{
			cell.textLabel?.text = myItems[indexPath.row] as? String
		}
		
		return cell
	}
	
	//    // Override to support conditional editing of the table view.
	//    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
	//        // Return NO if you do not want the specified item to be editable.
	//        return true
	//    }
	
	override func setEditing(editing: Bool, animated: Bool) {
		super.setEditing(editing, animated: animated)
		self.tableView.reloadData()
	}
	
	override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
		if (indexPath.row == myItems.count)
		{
			return UITableViewCellEditingStyle.Insert
		}
		else
		{
			return UITableViewCellEditingStyle.Delete
		}
	}
	
	override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
		if editingStyle == .Delete {
			// Delete the row from the data source
			myItems.removeObjectAtIndex(indexPath.row)
			tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
		} else if editingStyle == .Insert {
			// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
			myItems.insertObject(String(format: "Added %ld", indexPath.row), atIndex: indexPath.row)
			tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
		}
	}
	
	override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
		if (toIndexPath.row == myItems.count) //we only check the toIndexPath because we made the AddCell not to respond to move events
		{
			var tmp = myItems[fromIndexPath.row] as String
			myItems.removeObjectAtIndex(fromIndexPath.row)
			myItems.insertObject(tmp, atIndex: toIndexPath.row-1) //to keep it in valid range for the NSMutableArray
			self.tableView.reloadData()
		}
			
		else
		{
			var tmp = myItems[fromIndexPath.row] as String
			myItems.removeObjectAtIndex(fromIndexPath.row)
			myItems.insertObject(tmp, atIndex: toIndexPath.row)
		}
	}
	
	override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		if (indexPath.row == myItems.count)
		{
			return false
		}
		else
		{
			return true
		}
	}
	
	// MARK: - Navigation
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
	}
	
}
