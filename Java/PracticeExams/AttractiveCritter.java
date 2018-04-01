
/**
 * Write a description of class x here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */

public class AttractiveCritter extends Critter
{
    public ArrayList<Actor> getActors()
    {
        Grid<Actor> gr = getGrid();
        ArrayList<Location> locs = gr.getOccupiedLocations();
        ArrayList<Actor> actors = new ArrayList<Actor>();

        for (Location loc : locs)
        {
            Actor a = gr.get(loc);
            if (a != this)
                actors.add(a);
        } 1

        return actors;
    }

    public void processActors(ArrayList<Actor> actors)
    {
        Grid<Actor> gr = getGrid();
        for (Actor a : actors)
        {
            Location loc = a.getLocation();
            int dir = loc.getDirectionToward(getLocation());
            Location newLoc = loc.getAdjacentLocation(dir);
            if (gr.isValid(newLoc) && gr.get(newLoc) == null)
                a.moveTo(newLoc);
        }
    }
}

