<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:param name="personID" select="'P001'"/>
    <xsl:param name="date" select="'2024-08-26'"/>
    <xsl:param name="category" select="'Personal Assistance'"/>

    <!-- Root template -->
    <xsl:template match="/">
        <html>
            <body>
                <h1>Combined Report</h1>

                <!-- Scenario 1: List Services for a Specific User -->
                <h2>Services for User: <xsl:value-of select="$personID"/></h2>
                <table border="1">
                    <tr><th>Service Name</th><th>Date</th><th>Time</th></tr>
                    <xsl:for-each select="//Schedule[PersonID=$personID]">
                        <tr>
                            <td><xsl:value-of select="//Service[ServiceID=current()/ServiceID]/ServiceName"/></td>
                            <td><xsl:value-of select="Date"/></td>
                            <td><xsl:value-of select="Time"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                <hr/>

                <!-- Scenario 2: Display All Schedules for a Given Date -->
                <h2>Schedules for Date: <xsl:value-of select="$date"/></h2>
                <table border="1">
                    <tr><th>Service Name</th><th>Person</th><th>Time</th></tr>
                    <xsl:for-each select="//Schedule[Date=$date]">
                        <tr>
                            <td><xsl:value-of select="//Service[ServiceID=current()/ServiceID]/ServiceName"/></td>
                            <td><xsl:value-of select="//Person[PersonID=current()/PersonID]/Name"/></td>
                            <td><xsl:value-of select="Time"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                <hr/>

                <!-- Scenario 3: Show Service Providers by Category -->
                <h2>Service Providers for Category: <xsl:value-of select="$category"/></h2>
                <table border="1">
                    <tr><th>Provider Name</th><th>Service Name</th><th>Contact Info</th></tr>
                    <xsl:for-each select="//Service[Category=$category]">
                        <tr>
                            <td><xsl:value-of select="//Provider[ProviderID=current()/ProviderID]/Name"/></td>
                            <td><xsl:value-of select="ServiceName"/></td>
                            <td><xsl:value-of select="//Provider[ProviderID=current()/ProviderID]/ContactInfo"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                <hr/>

                <!-- Scenario 4: Report of Services Requested by Each User -->
                <h2>Report of Services Requested by Each User</h2>
                <table border="1">
                    <tr><th>User Name</th><th>Service Name</th><th>Date</th><th>Time</th></tr>
                    <xsl:for-each select="//Person">
                        <xsl:variable name="personID" select="PersonID"/>
                        <xsl:for-each select="//Schedule[PersonID=$personID]">
                            <tr>
                                <td><xsl:value-of select="//Person[PersonID=$personID]/Name"/></td>
                                <td><xsl:value-of select="//Service[ServiceID=current()/ServiceID]/ServiceName"/></td>
                                <td><xsl:value-of select="Date"/></td>
                                <td><xsl:value-of select="Time"/></td>
                            </tr>
                        </xsl:for-each>
                    </xsl:for-each>
                </table>
                <hr/>

                <!-- Scenario 5: Display User Profiles with Needs and Services -->
                <h2>User Profiles with Needs and Services</h2>
                <xsl:for-each select="//Person">
                    <h3>User: <xsl:value-of select="Name"/></h3>
                    <p><b>Age:</b> <xsl:value-of select="Age"/></p>
                    <p><b>Needs:</b></p>
                    <ul>
                        <xsl:for-each select="Needs"><li><xsl:value-of select="."/></li></xsl:for-each>
                    </ul>
                    <p><b>Scheduled Services:</b></p>
                    <table border="1">
                        <tr><th>Service Name</th><th>Date</th><th>Time</th></tr>
                        <xsl:for-each select="//Schedule[PersonID=current()/PersonID]">
                            <tr>
                                <td><xsl:value-of select="//Service[ServiceID=current()/ServiceID]/ServiceName"/></td>
                                <td><xsl:value-of select="Date"/></td>
                                <td><xsl:value-of select="Time"/></td>
                            </tr>
                        </xsl:for-each>
                    </table>
                    <hr/>
                </xsl:for-each>

            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
