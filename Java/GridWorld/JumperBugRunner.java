
import info.gridworld.actor.ActorWorld;
import info.gridworld.grid.Location;
import info.gridworld.grid.UnboundedGrid;
import java.awt.Color;

public class JumperBugRunner
{
    public static void main(String[] args)
    {
        ActorWorld world = new ActorWorld();
        JumperBug alice = new JumperBug();
        world.add(new Location(7, 8), alice);
        world.show();
    }
}