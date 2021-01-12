<?php
class City
{
    private $name;
    private $state;

    public function __construct($name,$state)
    {
        $this->name = $name;
        $this->state = $state;
    }

    public function getName()
    {
        return ($this->name);
    }
    public function getState()
    {
        return ($this->state);
    }

    public function setName($name)
    {
        $this->name = $name;
    }
    public function setState($state)
    {
        $this->state = $state;
    }
}
?>
