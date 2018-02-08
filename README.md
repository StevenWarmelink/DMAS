<a name="top"></a>
**Contents:**
- [Home](#introduction)
- [Setup - using uwp.rug.nl](#UWPsetup)
- [Setup - using local machine](#LinuxMachineSetup)
- [Simulation Parameters](#simulation)
- [Data format](#format)
- [Running the Simulation](#commands)

<a name="introduction"></a>
# Self-Organizing Cities: Multi-Agent Model of Population Segregation

This repository contains a multi-agent simulation modelling city segregation created by Team City. 

----------------------------------

<a name="UWPsetup"></a>
# SETUP through uwp.rug.nl

1. Download the `dmas-master.zip` file [here](https://github.com/suraoxa/dmas/archive/master.zip) or clone the repository.
2. Go to [uwp.rug.nl](https://uwp.rug.nl) and login using your rug credentials.
3. Select "Mathematics and Statistics". 
4. Go to the subfolder Mathworks Matlab and select `Matlab R2016B - EDU`.
5. After Matlab finishes booting, click on the black half-circle with 3 horizontal lines at the top to expand the citrix sub-menu
6. Select upload and upload the dmas-master.zip folder to any folder you like. 
7. Navigate to the folder you uploaded the zip to (in matlab) and double click the folder to make it your current working directory
8. Right-click the dmas-master.zip file and select extract. 
9. After extraction, you should now have a folder called dmas-master. Double click this folder to make it your current working directory.
10. From here you can run all the simulation and visualization files. 

[Back to the top](#top)

-----------------------------------

<a name="LinuxMachineSetup"></a>
# SETUP through a local linux machine

Please note that this approach requires you to have Matlab version `R2016b`. Other versions of Matlab may work, but we do not guarantee functionality for versions of Matlab other than version `R2016b`.

1. Download the `dmas-master.zip` file [here](https://github.com/suraoxa/dmas/archive/master.zip) or clone the repository.
2. Boot `Matlab R2016B`
3. Navigate to the folder you downloaded (or cloned) the zip to
4. Double click that folder to make it your active working directory
5. Extract the zip and make the new folder your current working directory. 
6. From here you can run all the simulation and visualization files. 

[Back to the top](#top)

-----------------------------------

<a name="simulation"></a>
# Simulation parameters

The simulation was written in Matlab (version `R2016b`) and can be run through the [online UWP](https://uwp.rug.nl) or a local UWP linux machine.

The code for this project consists of two seperate parts: the simulation itself and the analysis and visualization tools.

The **simulation** is handled through the file *main.m*. Various parameters can be changed in *main.m*:
  * `n_epochs`      : the number of epochs one simulation will last
  * `n_agents`      : the number of agents at the start of the simulation
  * `n_immigrants`  : the number of agents trying to enter the city each time step. 
  * `g_dims`        : city dimensions (e.g. [50,50])
  * `d_dims`        : neighbourhood dimensions (e.g. [5,5])
  * `init_strategy` : statistical distribution of initial population(s), i.e. **uniform** or **normal** distribution(s).
  * `init_params`   : The mean(s) and standard deviation(s) (in case of normal dist) or the lower and upper bounds (in case of uniform dist) of the initial population(s) as above.
  * `v_decay`       : how quickly an unoccupied house's value deteriorates over time
  * `m_factor`      : mortgage; the percentage of the house's value an agent pays to live in their house
  * `s_limit`       : agent value threshold under which they consider leaving the city
  * `s_update`      : update function; either 'logistic' or 'linear'. 'logistic' is the version as developed by benenson et al., 'linear' is our alternative
  * `p_leave`, `w_move_out`, `w_move_in`, `h_critera` : probability curves for migration en emigration  

[Back to the top](#top)

-----------------------------------


<a name="format"></a>
# Data format

The simulation outputs a datafile in which the following columns contain the following data:

| Col Num | |     Data                          |
|---------|-|-----------------------------------|
|    1    | | X-coordinate                      |
|    2    | | Y-coordinate                      |
|    3    | | House Value                       |
|    4    | | Agent ID                          |
|    5    | | Agent Value                       |
|    6    | | Agent Growth Rate                 |
|    7    | | Neighbourhood Value               |
|    8    | | Neighbourhood Tension             |
|    9    | | Neighbourhood Size                | 
|    10   | | Agent probability of Moving out   |
|    11   | | Epoch                             |


[Back to the top](#top)

------------------------------------
<a name="commands"></a>
# Running the simulation and visualization

- Run the simulation by running `main.m`

This generates a data file which can be read by the analysis and visualization files. Depending on the city (grid) size and number of agents this may take some time. For the analysis we suggest the following process:

- Open the `analysis.m` file.  
- Select the code section which you want to run. If you ran the simulation since the last time you ran the analysis, or this is the first time running the analysis file, run the first section to load the current data file. 
- Now you can either
  - Show the population distributions
  - Show the city's average agent value, average house value, average tension and ratio of occupied houses over time
  - Compute individual agents' lifetimes
  - Plot the number of Moore and Von Neumann neighbourhoods
  - Plot individual agents' value over time
  - show state over time. 4 plots:
    - Figure 1 shows house value per city cell
    - Figure 2 shows agent value per city cell
    - Figure 3 shows agent growth rate per city cell
    - Figure 4 shows the neighbourhood tension per city cell
- You can run the section you are interested in by pressing the `Run Section` button in the section you want to analyze. We strongly suggest running only one section at a time since all sections produce graphs, and some modes produce a **lot** of graphs. 

[Back to the top](#top)