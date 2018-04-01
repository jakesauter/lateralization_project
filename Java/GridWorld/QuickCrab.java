package GridWorld;

import info.gridworld.actor.Actor; 
import info.gridworld.actor.Critter; 
import info.gridworld.grid.Grid; 
import info.gridworld.grid.Location; 
import java.awt.Color; 
import java.util.ArrayList; 

public class QuickCrab extends CrabCritter 
{
    public QuickCrab() 
    { 
        setColor(Color.pink); 
    } 
    
    public ArrayList<Location> getMoveLocations() 
    { 
        ArrayList<Location> locarray = new ArrayList<Location>(); 
        Grid grid = getGrid(); 

        add(locarray,getDirection() + Location.LEFT); 
        add(locarray,getDirection() + Location.RIGHT); 

        if (locarray.size() == 0) 
        {
            return super.getMoveLocations(); 
        }

        return locarray; 
    } 

    private void add(ArrayList<Location> locarray,int dir) 
    { 
        Grid grid = getGrid(); 
        Location location = getLocation(); 
        Location locationtwo;
        Location temp = location.getAdjacentLocation(dir); 

        if(grid.isValid(temp) && grid.get(temp) == null) 
        { 
            locationtwo = temp.getAdjacentLocation(dir); 
            if(grid.isValid(locationtwo) && grid8.get(locationtwo)== null) 
            {
                locarray.add(locationtwo); 
            }
        } 
    } 
} 
